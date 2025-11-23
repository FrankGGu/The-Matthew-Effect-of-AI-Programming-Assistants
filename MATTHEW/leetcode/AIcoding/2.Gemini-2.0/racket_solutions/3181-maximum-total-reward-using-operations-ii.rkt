(define (maximum-total-reward ops rewards)
  (define n (vector-length rewards))
  (define (solve i j)
    (cond
      [(< i 0) 0]
      [(>= j (length ops)) 0]
      [else (max (+ (vector-ref ops j) (vector-ref rewards i) (solve (- i 1) (+ j 1)))
                 (solve i (+ j 1)))]))
  (solve (- n 1) 0))