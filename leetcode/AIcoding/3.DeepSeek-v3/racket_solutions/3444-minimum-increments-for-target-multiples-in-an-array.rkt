(define/contract (min-increment-for-target nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums (sort nums <)]
             [increments 0]
             [prev -1])
    (if (null? nums)
        increments
        (let* ([current (car nums)]
               [new-current (max (add1 prev) current)]
               [new-increments (+ increments (- new-current current))])
          (loop (cdr nums) new-increments new-current)))))