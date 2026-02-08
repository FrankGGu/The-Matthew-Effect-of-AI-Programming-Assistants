(define (maximum-product nums)
  (define sorted-nums (sort nums >))
  (max (* (list-ref sorted-nums 0) (list-ref sorted-nums 1) (list-ref sorted-nums 2))
       (* (list-ref sorted-nums 0) (list-ref sorted-nums 1) (list-ref sorted-nums (- (length sorted-nums) 1)))))