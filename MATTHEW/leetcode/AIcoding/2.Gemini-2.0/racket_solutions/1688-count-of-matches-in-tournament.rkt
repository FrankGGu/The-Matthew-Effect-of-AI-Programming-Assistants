(define (number-of-matches n)
  (if (= n 1)
      0
      (+ (floor (/ n 2)) (number-of-matches (ceiling (/ n 2))))))