#lang racket

(define (find-number-of-winning-players nums k)
  (define (count-wins nums k)
    (define n (length nums))
    (define arr (list->vector nums))
    (define res (make-vector n 0))
    (for ([i (in-range n)])
      (define j (modulo (+ i k) n))
      (when (< (vector-ref arr i) (vector-ref arr j))
        (vector-set! res i (+ (vector-ref res i) 1))))
    (vector->list res))
  (apply + (count-wins nums k)))