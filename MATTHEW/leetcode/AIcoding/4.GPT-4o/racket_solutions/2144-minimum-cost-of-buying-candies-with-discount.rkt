(define (minimumCost cost)
  (define (helper costs)
    (if (null? costs)
        0
        (let ((n (length costs)))
          (if (= n 1)
              (car costs)
              (+ (car costs)
                 (helper (if (<= n 3)
                             '()
                             (cdr (cdr costs)))))))))
  (define sorted-cost (sort cost <))
  (helper sorted-cost))

(minimumCost '(1 2 3)) ; Example test case