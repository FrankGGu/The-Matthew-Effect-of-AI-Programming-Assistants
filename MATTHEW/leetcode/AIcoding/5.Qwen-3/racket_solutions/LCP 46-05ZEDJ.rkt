(define (min-operations target)
  (define (helper n)
    (if (<= n 0)
        0
        (+ (quotient n 2) (helper (remainder n 2)))))
  (helper target))