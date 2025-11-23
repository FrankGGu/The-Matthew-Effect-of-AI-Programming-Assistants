(define (countBits n)
  (define (popcount x)
    (if (= x 0)
        0
        (+ (modulo x 2) (popcount (quotient x 2)))))
  (map popcount (range 0 (+ n 1))))