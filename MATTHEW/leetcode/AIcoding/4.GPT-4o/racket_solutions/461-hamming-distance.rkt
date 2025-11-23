(define (hammingDistance x y)
  (define (countBits n)
    (if (= n 0)
        0
        (+ (modulo n 2) (countBits (quotient n 2)))))
  (countBits (bitwise-xor x y)))