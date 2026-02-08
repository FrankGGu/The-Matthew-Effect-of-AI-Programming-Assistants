(define (find-minimum-cost-to-remove-array-elements nums)
  (let* ([n (length nums)]
         [sorted-nums (sort nums <)])
    (for/sum ([x sorted-nums]
              [i (in-naturals)])
      (* x (- n i)))))