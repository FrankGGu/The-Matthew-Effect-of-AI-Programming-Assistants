#lang racket

(define (min-hrs training time)
  (define (helper t acc)
    (if (>= t time)
        acc
        (helper (+ t (car training)) (+ acc 1))))
  (helper 0 0))