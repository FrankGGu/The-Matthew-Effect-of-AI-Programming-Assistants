(define/contract (maximum-bags capacity rocks additionalRocks)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([diff (map (lambda (c r) (- c r)) capacity rocks)]
         [sorted-diff (sort diff <)]
         [n (length sorted-diff)]
         [res 0]
         [remaining additionalRocks])
    (for ([i (in-range n)])
      (when (>= remaining (list-ref sorted-diff i))
        (set! remaining (- remaining (list-ref sorted-diff i)))
        (set! res (+ res 1))))
    res))