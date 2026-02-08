(define/contract (permute nums)
  (-> (listof exact-integer?) (listof (listof exact-integer?)))
  (cond
    [(null? nums) '(())]
    [else
     (for*/list ([x nums]
                 [ys (permute (remove x nums))])
       (cons x ys))]))