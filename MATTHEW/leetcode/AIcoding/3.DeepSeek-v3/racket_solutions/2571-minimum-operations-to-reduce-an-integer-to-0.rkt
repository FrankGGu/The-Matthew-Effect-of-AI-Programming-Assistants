(define/contract (min-operations n)
  (-> exact-integer? exact-integer?)
  (let loop ([n n] [ops 0])
    (cond
      [(zero? n) ops]
      [(even? n) (loop (quotient n 2) ops)]
      [else (min (loop (add1 n) (add1 ops))
                 (loop (sub1 n) (add1 ops)))])))