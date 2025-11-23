(define/contract (min-operations nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([nums nums] [collected (set)] [ops 0])
    (cond
      [(set-member? collected k) ops]
      [(null? nums) ops]
      [else
       (let ([num (car nums)])
         (if (<= num k)
             (loop (cdr nums) (set-add collected num) (add1 ops))
             (loop (cdr nums) collected (add1 ops))))])))