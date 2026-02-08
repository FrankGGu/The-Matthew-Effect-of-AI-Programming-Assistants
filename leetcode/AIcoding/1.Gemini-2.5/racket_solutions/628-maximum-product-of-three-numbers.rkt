(define (maximum-product nums)
  (let* ([sorted-nums (sort nums <)]
         [n (length sorted-nums)]
         [prod1 (* (list-ref sorted-nums (- n 1))
                   (list-ref sorted-nums (- n 2))
                   (list-ref sorted-nums (- n 3)))]
         [prod2 (* (list-ref sorted-nums 0)
                   (list-ref sorted-nums 1)
                   (list-ref sorted-nums (- n 1)))])
    (max prod1 prod2)))