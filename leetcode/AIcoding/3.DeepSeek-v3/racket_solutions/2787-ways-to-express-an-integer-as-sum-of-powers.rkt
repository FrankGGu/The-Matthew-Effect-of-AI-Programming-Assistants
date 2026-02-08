#lang racket

(define (number-of-ways n x)
  (define (helper remaining max-base)
    (cond [(= remaining 0) 1]
          [(< remaining 0) 0]
          [(< max-base 1) 0]
          [else (+ (helper remaining (sub1 max-base))
                  (helper (- remaining (expt max-base x)) (sub1 max-base)))]))
  (helper n (expt n (/ 1 x))))