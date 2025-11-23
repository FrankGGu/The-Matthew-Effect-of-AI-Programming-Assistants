(define (min-operations nums k)
  (let loop ([nums (sort nums <)]
             [operations 0])
    (cond
      [(null? nums) operations]
      [(>= (car nums) k) operations]
      [else (loop (cdr nums) (+ operations (- k (car nums))))])))