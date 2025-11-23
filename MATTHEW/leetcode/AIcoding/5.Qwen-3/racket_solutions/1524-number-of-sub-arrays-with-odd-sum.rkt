(define (odd-sum-subarrays nums)
  (let ((even 1) (odd 0) (sum 0))
    (for-each
     (lambda (num)
       (set! sum (+ sum num))
       (if (odd? sum)
           (begin
             (set! odd (+ odd even))
             (set! even even))
           (begin
             (set! even (+ even odd))
             (set! odd odd))))
     nums)
    odd))