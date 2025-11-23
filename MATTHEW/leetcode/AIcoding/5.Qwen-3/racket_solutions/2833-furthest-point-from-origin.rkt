#lang racket

(define (max-distance x y)
  (let ([x (string->number x)]
        [y (string->number y)])
    (if (> (abs x) (abs y))
        (abs x)
        (abs y))))