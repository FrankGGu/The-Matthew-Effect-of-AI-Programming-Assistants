(define (max-product-difference nums)
  (define sorted-nums (sort nums <))
  (- (* (last sorted-nums) (second-to-last sorted-nums))
     (* (first sorted-nums) (second sorted-nums))))