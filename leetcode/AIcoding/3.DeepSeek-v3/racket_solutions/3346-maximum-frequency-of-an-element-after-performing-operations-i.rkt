(define/contract (max-frequency nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([sorted (sort nums <)]
         [n (length sorted)]
         [left 0]
         [right 0]
         [sum 0]
         [max-freq 0])
    (for ([right (in-range n)])
      (set! sum (+ sum (list-ref sorted right)))
      (while (> (* (- right left -1) (list-ref sorted right)) (+ sum k))
        (set! sum (- sum (list-ref sorted left)))
        (set! left (+ left 1)))
      (set! max-freq (max max-freq (- right left -1))))
    max-freq))