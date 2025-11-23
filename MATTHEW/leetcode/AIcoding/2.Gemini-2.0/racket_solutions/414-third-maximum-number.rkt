(define (third-max nums)
  (let* ([distinct-nums (remove-duplicates nums)]
         [len (length distinct-nums)])
    (cond
      [(= len 0) #f]
      [(= len 1) (car distinct-nums)]
      [(= len 2) (max (car distinct-nums) (cadr distinct-nums))]
      [else
       (let* ([sorted-nums (sort distinct-nums >)])
         (if (>= len 3)
             (list-ref sorted-nums 2)
             (car sorted-nums))))]))