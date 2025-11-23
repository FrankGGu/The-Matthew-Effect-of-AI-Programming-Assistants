(define (array-pair-sum nums)
  (define (helper sorted)
    (if (null? (cdr sorted))
        0
        (+ (car sorted) (helper (cddr sorted)))))
  (helper (sort nums <)))