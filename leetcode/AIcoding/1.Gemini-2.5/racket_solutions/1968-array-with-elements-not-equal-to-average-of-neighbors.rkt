(define (rearrange-array nums)
  (let* ((n (length nums))
         (sorted-nums (sort nums <)))
    (build-list n
                (lambda (i)
                  (let ((k (quotient i 2)))
                    (if (even? i)
                        (list-ref sorted-nums k)
                        (list-ref sorted-nums (- (- n 1) k))))))))