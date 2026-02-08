(define (hammingWeight n)
  (define (count-ones n)
    (if (= n 0)
        0
        (+ (modulo n 2) (count-ones (quotient n 2)))))
  (count-ones n))