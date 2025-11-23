(define/contract (fill-cups amount)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([max-cup (apply max amount)]
         [sum-cups (apply + amount)])
    (max max-cup (quotient (+ sum-cups 1) 2))))