#lang racket

(define (min-cost-to-set-cooking-time (target-time . rest) . _)
  (define (cost t)
    (if (<= t target-time)
        (- target-time t)
        (+ (* (- t target-time) 2) 100)))
  (define times (append (list target-time) rest))
  (apply min (map cost times)))