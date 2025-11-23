#lang racket

(define (build-matrix rows cols k)
  (define (f i j)
    (modulo (+ (* i cols) j) k))
  (for/vector ([i (in-range rows)])
    (for/vector ([j (in-range cols)])
      (f i j))))