#lang racket

(define (count-hidden-sequences d)
  (define (f s)
    (if (null? s)
        1
        (let ((x (car s)))
          (* (f (cdr s)) (if (= x 0) 1 (add1 (abs x)))))))
  (f d))