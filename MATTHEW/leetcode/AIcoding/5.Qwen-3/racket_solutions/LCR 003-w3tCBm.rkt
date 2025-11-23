(define (count-bits n)
  (define (count-ones x)
    (if (= x 0)
        0
        (+ (remainder x 2) (count-ones (quotient x 2)))))
  (map count-ones (range (add1 n))))