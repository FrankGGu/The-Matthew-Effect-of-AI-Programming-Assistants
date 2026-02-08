(define (find-gcd-of-array nums)
  (let* ((min-val (apply min nums))
         (max-val (apply max nums)))
    (gcd min-val max-val)))