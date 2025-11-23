(define/contract (minimum-cost cost)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([sorted-cost (sort cost >)]
             [total 0]
             [i 0])
    (cond
      [(null? sorted-cost) total]
      [(= (modulo i 3) 2) (loop (cdr sorted-cost) total (add1 i))]
      [else (loop (cdr sorted-cost) (+ total (car sorted-cost)) (add1 i))])))