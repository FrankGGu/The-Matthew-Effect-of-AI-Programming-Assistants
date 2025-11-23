(define (count-lights-records lights)
  (define (count-ways n)
    (if (<= n 1)
        1
        (+ (count-ways (- n 1)) (count-ways (- n 2)))))
  (count-ways lights))

(define (numOfWays lights)
  (count-lights-records lights))