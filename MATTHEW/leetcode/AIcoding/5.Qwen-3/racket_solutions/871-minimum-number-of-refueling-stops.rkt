#lang racket

(define (min-refuel-stops target dist)
  (define (helper stations fuel res)
    (cond [(null? stations) res]
          [(<= target (car stations)) res]
          [else (helper (cdr stations) (- fuel (car stations)) (+ res 1))]))
  (helper dist 0 0))