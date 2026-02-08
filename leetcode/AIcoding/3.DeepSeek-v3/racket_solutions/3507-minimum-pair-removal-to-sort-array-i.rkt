(define/contract (minimum-pair-removal nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums nums] [prev -inf.0] [removed 0])
    (cond
      [(null? nums) removed]
      [(> (car nums) prev) (loop (cdr nums) (car nums) removed)]
      [else (loop (cdr nums) prev (add1 removed))])))