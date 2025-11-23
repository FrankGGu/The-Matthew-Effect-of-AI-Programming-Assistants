(define (trailingZeroes n)
  (define (count-factors x)
    (if (< x 5) 0
        (+ (count-factors (floor (/ x 5))) (floor (/ x 5)))))
  (count-factors n))