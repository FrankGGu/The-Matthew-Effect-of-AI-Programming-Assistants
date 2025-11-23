(define (largest-element-after-merge-operations nums)
  (define (helper nums)
    (if (null? nums) 0
        (let* ((sorted-nums (sort nums >))
               (max-element (car sorted-nums))
               (rest (cdr sorted-nums)))
          (if (null? rest)
              max-element
              (let ((merged (apply + rest)))
                (max max-element merged))))))
  (helper nums))