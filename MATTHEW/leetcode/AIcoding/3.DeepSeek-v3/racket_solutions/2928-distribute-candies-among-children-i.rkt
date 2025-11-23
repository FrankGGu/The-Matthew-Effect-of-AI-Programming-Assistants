(define/contract (distribute-candies n limit)
  (-> exact-integer? exact-integer? exact-integer?)
  (define (helper n limit)
    (cond
      [(< n 0) 0]
      [(= n 0) 1]
      [else
       (for/sum ([i (in-range 0 (add1 limit))])
         (helper (- n i) limit))]))
  (helper n limit))