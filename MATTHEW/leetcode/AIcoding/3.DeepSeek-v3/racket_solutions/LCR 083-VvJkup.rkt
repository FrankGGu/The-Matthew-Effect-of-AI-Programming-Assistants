(define/contract (permute nums)
  (-> (listof exact-integer?) (listof (listof exact-integer?)))
  (if (null? nums)
      '(())
      (apply append
             (map (lambda (x)
                    (map (lambda (p) (cons x p))
                         (permute (remove x nums))))
                  nums))))