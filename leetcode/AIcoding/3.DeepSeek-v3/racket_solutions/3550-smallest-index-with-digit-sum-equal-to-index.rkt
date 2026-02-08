(define/contract (smallest-equal nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([i 0] [nums nums])
    (cond
      [(null? nums) -1]
      [(= (modulo i 10) (car nums)) i]
      [else (loop (add1 i) (cdr nums))])))