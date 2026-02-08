(define (count-elements nums)
  (let* ((min (apply min nums))
         (max (apply max nums)))
    (if (or (null? nums) (equal? min max))
        0
        (length (filter (lambda (x) (and (> x min) (< x max))) nums)))))

(define (numElementsWithStrictlySmallerAndGreater nums)
  (count-elements nums))