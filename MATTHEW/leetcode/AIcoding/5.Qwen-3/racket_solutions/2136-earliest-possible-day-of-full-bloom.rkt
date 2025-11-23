#lang racket

(define (earliest-day-of-full-bloom flower-ids plant-time bloom-time)
  (define n (length flower-ids))
  (define sorted (sort (map list flower-ids plant-time bloom-time) (lambda (a b) (< (car a) (car b)))))
  (define-values (plant-bloom)
    (for/fold ([max 0] [current 0]) ([i (in-range n)])
      (define p (list-ref plant-time i))
      (define b (list-ref bloom-time i))
      (define new-current (+ current p))
      (values (max max (+ new-current b)) new-current)))
  (cdr plant-bloom))