(define (count-houses distance)
  (define (helper n)
    (if (> n distance)
        0
        (+ (if (= (abs (- n (floor (/ distance 2)))) (floor (/ distance 2))) 1 0)
           (helper (+ n 1)))))
  (helper 0))