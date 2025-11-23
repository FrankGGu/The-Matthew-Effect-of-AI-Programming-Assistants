(define (myPow x n)
  (define (helper a b)
    (cond
      [(= b 0) 1]
      [(even? b) (let ([half (helper a (/ b 2))])
                   (* half half))]
      [else (* a (helper a (- b 1)))]))
  (if (< n 0)
      (/ 1 (helper x (- n)))
      (helper x n)))