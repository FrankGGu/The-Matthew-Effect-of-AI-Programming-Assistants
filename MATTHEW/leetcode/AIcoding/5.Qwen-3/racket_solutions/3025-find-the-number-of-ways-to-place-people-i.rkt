#lang racket

(define (number-of-ways people)
  (define n (length people))
  (define (count x y)
    (if (<= x y) 1 0))
  (define (f i j)
    (cond [(= i n) 0]
          [(= j n) (f (+ i 1) 0)]
          [else (+ (count (list-ref people i) (list-ref people j)) (f i (+ j 1)))]))
  (f 0 0))