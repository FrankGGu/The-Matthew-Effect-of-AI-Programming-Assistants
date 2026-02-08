(define/contract (get-maximum-consecutive coins)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([sorted-coins (sort coins <)]
             [max-reach 1]
             [i 0])
    (cond
      [(or (null? sorted-coins) (>= i (length sorted-coins))) max-reach]
      [(<= (list-ref sorted-coins i) max-reach)
       (loop sorted-coins (+ max-reach (list-ref sorted-coins i)) (add1 i))]
      [else max-reach])))