(define (minBitFlips start goal)
  (define (count-bits n)
    (if (= n 0)
        0
        (+ (modulo n 2) (count-bits (quotient n 2)))))
  (count-bits (bitwise-xor start goal)))