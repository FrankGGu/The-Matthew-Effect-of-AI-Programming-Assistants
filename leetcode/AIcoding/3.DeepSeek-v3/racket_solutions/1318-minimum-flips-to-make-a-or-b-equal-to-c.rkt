(define (min-flips a b c)
  (let loop ([a a] [b b] [c c] [flips 0])
    (if (and (zero? a) (zero? b) (zero? c))
        flips
        (let ([a-bit (bitwise-and a 1)]
              [b-bit (bitwise-and b 1)]
              [c-bit (bitwise-and c 1)])
          (cond
            [(= (bitwise-ior a-bit b-bit) c-bit)
             (loop (arithmetic-shift a -1) (arithmetic-shift b -1) (arithmetic-shift c -1) flips)]
            [else
             (loop (arithmetic-shift a -1) (arithmetic-shift b -1) (arithmetic-shift c -1)
                   (+ flips (if (zero? c-bit) (+ a-bit b-bit) 1))])))))