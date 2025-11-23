(define (reaching-points sx sy dx dy)
  (define (helper x y)
    (cond [(and (= x dx) (= y dy)) #t]
          [(or (> x dx) (> y dy)) #f]
          [else
           (if (< x y)
               (helper x (- y (* (quotient (- y x) (abs (- x y))) x)))
               (helper (- x (* (quotient (- x y) (abs (- x y))) y)) y))]))
  (helper sx sy))