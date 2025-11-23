(define/contract (min-operations nums target)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([nums (sort nums <)]
             [target (sort target <)]
             [ops 0])
    (cond
      [(null? nums) ops]
      [(null? target) ops]
      [(= (car nums) (car target)) (loop (cdr nums) (cdr target) ops)]
      [(< (car nums) (car target)) (loop (cdr nums) target (add1 ops))]
      [else (loop nums (cdr target) (add1 ops))])))