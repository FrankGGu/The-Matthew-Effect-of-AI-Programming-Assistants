(define/contract (min-cost-to-equalize-array nums cost1 cost2)
  (-> (listof exact-integer?) exact-integer? exact-integer? exact-integer?)
  (let* ([n (length nums)]
         [max-num (apply max nums)]
         [min-num (apply min nums)]
         [total (for/sum ([num nums]) (- max-num num))]
         [max-op1 (* total cost1)]
         [max-op2 (let ([m (quotient total 2)])
                    (+ (* m cost2) (* (- total (* 2 m)) cost1)))]
         [initial-min (min max-op1 max-op2)])
    (if (<= n 2)
        initial-min
        (let ([diff (- max-num min-num)])
          (min initial-min
               (let loop ([k 1])
                 (if (> k diff)
                     initial-min
                     (let* ([new-max (+ max-num k)]
                            [new-total (for/sum ([num nums]) (- new-max num))]
                            [op1 (* new-total cost1)]
                            [op2 (let ([m (quotient new-total 2)])
                                   (+ (* m cost2) (* (- new-total (* 2 m)) cost1)))])
                       (min (min op1 op2) (loop (+ k 1))))))))))