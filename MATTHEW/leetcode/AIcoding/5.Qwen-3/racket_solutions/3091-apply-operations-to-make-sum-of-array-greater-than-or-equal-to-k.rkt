#lang racket

(define (min-operations k)
  (define (loop n)
    (if (>= (* n (+ n 1)) (* 2 k))
        (- n 1)
        (loop (+ n 1))))
  (loop 1))