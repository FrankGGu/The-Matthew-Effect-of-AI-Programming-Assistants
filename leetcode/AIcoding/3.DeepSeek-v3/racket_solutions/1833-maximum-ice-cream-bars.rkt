(define/contract (max-ice-cream costs coins)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([sorted-costs (sort costs <)]
             [remaining-coins coins]
             [count 0])
    (cond
      [(null? sorted-costs) count]
      [(<= (car sorted-costs) remaining-coins)
       (loop (cdr sorted-costs)
             (- remaining-coins (car sorted-costs))
             (add1 count))]
      [else count])))