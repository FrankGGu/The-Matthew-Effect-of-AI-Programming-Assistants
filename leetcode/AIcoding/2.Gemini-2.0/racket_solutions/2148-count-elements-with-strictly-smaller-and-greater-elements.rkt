(define (count-elements nums)
  (if (<= (length nums) 2)
      0
      (let* ((min-val (apply min nums))
             (max-val (apply max nums))
             (count (length (filter (lambda (x) (and (> x min-val) (< x max-val))) nums))))
        count)))