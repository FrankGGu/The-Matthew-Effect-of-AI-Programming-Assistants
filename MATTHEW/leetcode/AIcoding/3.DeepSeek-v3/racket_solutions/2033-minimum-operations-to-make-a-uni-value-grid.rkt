(define/contract (min-operations grid k)
  (-> (listof (listof exact-integer?)) exact-integer? exact-integer?)
  (let* ([flattened (apply append grid)]
         [sorted (sort flattened <)]
         [median (list-ref sorted (quotient (length sorted) 2))]
    (for/sum ([num sorted])
      (abs (- num median)))))