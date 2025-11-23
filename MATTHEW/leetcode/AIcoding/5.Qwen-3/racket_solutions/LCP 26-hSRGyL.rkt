#lang racket

(define (min-hops n)
  (define (helper x res)
    (if (<= x 0)
        res
        (let ((next (expt (floor (sqrt x)) 2)))
          (helper (- x next) (+ res 1)))))
  (helper n 0))