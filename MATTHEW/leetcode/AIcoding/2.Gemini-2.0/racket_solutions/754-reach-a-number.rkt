(define (reach-number target)
  (define abs-target (abs target))
  (define (helper k sum)
    (cond
      [(>= sum abs-target)
       (if (even? (- sum abs-target))
           k
           (helper (+ k 1) (+ sum k 1)))]
      [else (helper (+ k 1) (+ sum k 1))]))
  (helper 0 0))