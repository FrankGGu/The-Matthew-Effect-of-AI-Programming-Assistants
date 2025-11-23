(define (find-maximum-amount nums)
  (define (helper nums count)
    (if (null? nums)
        count
        (let ((num (car nums)))
          (if (>= num 10)
              (helper (cdr nums) (+ count 1))
              (helper (cdr nums) count)))))
  (helper nums 0))