(define (array-pair-sum nums)
  (let ((sorted-nums (sort nums <)))
    (let loop ((lst sorted-nums) (sum 0))
      (if (null? lst)
          sum
          (loop (cdr (cdr lst)) (+ sum (car lst)))))))