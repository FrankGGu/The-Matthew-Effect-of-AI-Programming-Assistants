(define (min-moves nums)
  (let* ((min-val (apply min nums))
         (sum (apply + nums)))
    (- sum (* (length nums) min-val))))