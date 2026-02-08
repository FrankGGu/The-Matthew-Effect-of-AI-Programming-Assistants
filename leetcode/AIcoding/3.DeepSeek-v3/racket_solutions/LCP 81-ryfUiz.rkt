(define (bitwise-nand a b)
  (bitwise-not (bitwise-and a b)))

(define (getFirstSetBit n)
  (if (zero? n)
      0
      (let loop ([n n] [pos 0])
        (if (odd? n)
            pos
            (loop (arithmetic-shift n -1) (add1 pos))))))

(define (minimum-flips a b c)
  (let loop ([a a] [b b] [c c] [flips 0])
    (if (and (zero? a) (zero? b) (zero? c))
        flips
        (let* ([a-bit (bitwise-and a 1)]
               [b-bit (bitwise-and b 1)]
               [c-bit (bitwise-and c 1)]
               [new-flips (cond
                            [(= c-bit 1) (if (and (zero? a-bit) (zero? b-bit)) 1 0)]
                            [else (+ a-bit b-bit)])])
          (loop (arithmetic-shift a -1) (arithmetic-shift b -1) (arithmetic-shift c -1) (+ flips new-flips))))))