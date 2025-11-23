(define/contract (max-count m n ops)
  (-> exact-integer? exact-integer? (listof (listof exact-integer?)) exact-integer?)
  (if (null? ops)
      (* m n)
      (let ([min-a (apply min (map car ops))]
            [min-b (apply min (map cadr ops))])
        (* min-a min-b))))