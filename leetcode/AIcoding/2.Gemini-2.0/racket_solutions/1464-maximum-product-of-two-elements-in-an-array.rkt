(define (max-product-difference nums)
  (let* ([sorted-nums (sort nums >)]
         [a (list-ref sorted-nums 0)]
         [b (list-ref sorted-nums 1)])
    (* (- a 1) (- b 1))))