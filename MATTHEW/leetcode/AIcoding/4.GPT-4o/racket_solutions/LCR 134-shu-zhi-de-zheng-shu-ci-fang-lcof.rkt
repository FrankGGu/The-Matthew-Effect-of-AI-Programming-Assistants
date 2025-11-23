(define (myPow x n)
  (define (helper x n)
    (cond
      [(= n 0) 1]
      [(< n 0) (/ 1 (helper x (- n)))]
      [else (if (even? n)
                (let ([half (helper x (/ n 2))])
                  (* half half))
                (* x (helper x (- n 1))))]))
  (helper x n))