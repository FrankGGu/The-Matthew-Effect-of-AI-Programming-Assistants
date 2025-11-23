(define (maximize-greatness nums)
  (define sorted-nums (sort nums <))
  (define (helper sorted-nums used)
    (cond
      [(empty? sorted-nums) 0]
      [(empty? used) (length sorted-nums)]
      [else
       (if (> (car sorted-nums) (car used))
           (+ 1 (helper (cdr sorted-nums) (cdr used)))
           (helper sorted-nums (cdr used)))]))
  (helper sorted-nums sorted-nums))