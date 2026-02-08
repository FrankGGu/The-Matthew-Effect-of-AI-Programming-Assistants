(define/contract (min-deletion nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums nums] [index 0] [deletions 0])
    (cond
      [(null? nums) deletions]
      [(null? (cdr nums)) (if (even? index) deletions (add1 deletions))]
      [(= (car nums) (cadr nums))
       (loop (cdr nums) index (add1 deletions))]
      [else (loop (cddr nums) (add1 index) deletions)])))