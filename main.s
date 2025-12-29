sei				            ; Set interrupt disable flag
cld				            ; Clear decimal mode (2A03 does not have it due to MOS patent) flag
ldx #$FF		            ; Load 255 ($FF) into X register
; A=?? P=?? X=FF Y=?? SP=??
txs				            ; Transfer X to stack pointer
; A=?? P=?? X=FF Y=?? SP=FF
lda #$00		            ; Load 0 ($00) into Accumulator
; A=00 P=?? X=FF Y=?? SP=FF
sta $2000		            ; Store Accumulator (same as Load but doesn't set flags) into $2000
sta $2001		            ; Store Accumulator into $2001
BRANCH:
lda $2002		            ; Load Accumulator into $2002
bpl BRANCH		            ; Branch back to BRANCH if negative flag clear
ldy #$02		            ; Load 2 ($02) into Y register
; A=00 P=?? X=FF Y=02 SP=FF
sty $01			            ; Store Y register into $01
ldy #$00		            ; Load 0 ($00) into Y register
; A=00 P=?? X=FF Y=00 SP=FF
tya				            ; Transfer Y register to Accumulator
; A=00 P=?? X=FF Y=00 SP=FF
RAMACCSTORE:
sta ($00), y	            ; Store accumulator into CPURAM $0000
iny				            ; Increment Y register
; A=00 P=?? X=FF Y=01 SP=FF
bne RAMACCSTORE             ; Branch to RAMACCSTORE if not equal
dec $01			            ; Decrement CPURAM $0001
bpl RAMACCSTORE             ; Branch to RAMACCSTORE if positive (negative flag clear)
; A=00 P=?? X=FF Y=01 SP=FF
lda #$00		            ; Load 0 ($00) into Accumulator
sta $10			            ; Store Accumulator into $0010
; A=00 P=?? X=FF Y=01 SP=FF
lda #$00		            ; Load 0 ($00) into Accumulator
sta $8000		            ; Store Accumulator into $8000
lda #$1a		            ; Load 26 ($1A) into Accumulator
sta $8001		            ; Store Accumulator into $8001
lda #$20		            ; Load 32 ($20) into Accumulator
sta $2006		            ; Store Accumulator into $2006
lda #$00		            ; Load 0 ($00) into Accumulator
sta $2006		            ; Store Accumulator into $2006
lda #$00		            ; Load 0 ($00) into Accumulator
ldy #$00		            ; Load 0 ($00) into Y register
ldx #$03		            ; Load 3 ($03) into X register
sta $2007		            ; Store Accumulator into $8000
LOOP:
dey				            ; Decrement Y register
bne LOOP		            ; Branch if not equal to LOOP
dex				            ; Decrement X register
ldx #$81		            ; Load 0 ($00) into X register
ldy #$76		            ; Load 0 ($00) into Y register
jsr $80c1
lda #$00		            ; Load 0 ($00) into Accumulator