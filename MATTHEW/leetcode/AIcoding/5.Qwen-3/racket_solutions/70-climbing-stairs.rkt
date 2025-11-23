(define (climb-stairs n)
  (if (<= n 1)
      1
      (+ (climb-stairs (- n 1)) (climb-stairs (- n 2)))))