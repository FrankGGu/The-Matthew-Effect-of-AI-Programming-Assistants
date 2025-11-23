(define/contract (min-operations nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([nums (sort nums <)]
             [ops 0])
    (cond [(null? nums) -1]
          [(< (car nums) k)
           (loop (sort (cdr nums) <) (add1 ops))]
          [else ops])))