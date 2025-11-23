(define/contract (distribute-candies n limit)
  (-> exact-integer? exact-integer? exact-integer?)
  (define (count-ways n limit)
    (cond
      [(< n 0) 0]
      [(= n 0) 1]
      [else
       (for/sum ([i (in-range 0 (add1 (min n limit)))])
         (count-ways (- n i) limit))]))
  (let ([total (count-ways n limit)])
    (if (>= n (* 3 (add1 limit)))
        0
        (let ([bad (count-ways (- n (add1 limit)) limit)])
          (- total (* 3 bad) (* 3 (count-ways (- n (* 2 (add1 limit))) limit)) (count-ways (- n (* 3 (add1 limit))) limit))))))