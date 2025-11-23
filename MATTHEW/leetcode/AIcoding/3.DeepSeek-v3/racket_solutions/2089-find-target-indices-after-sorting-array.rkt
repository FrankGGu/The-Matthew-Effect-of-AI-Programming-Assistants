(define/contract (target-indices nums target)
  (-> (listof exact-integer?) exact-integer? (listof exact-integer?))
  (let ([sorted-nums (sort nums <)])
    (for/list ([num sorted-nums]
               [i (in-naturals)]
               #:when (equal? num target))
      i)))