(define (hamming-distance x y)
  (define (count-ones n)
    (if (= n 0)
        0
        (+ (remainder n 2) (count-ones (quotient n 2)))))
  (count-ones (bitwise-xor x y)))