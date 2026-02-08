(define/contract (minimum-array-length-after-pair-removals nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums (sort nums <)] [stack '()])
    (cond
      [(null? nums) (length stack)]
      [(null? stack) (loop (cdr nums) (cons (car nums) stack))]
      [(> (car nums) (car stack)) (loop (cdr nums) (cdr stack))]
      [else (loop (cdr nums) (cons (car nums) stack))])))