#lang racket

(define (earliest_second_to_mark_indices I)
  (define seconds (vector 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
  (define (mark-index i)
    (if (< i 60)
        (vector-set! seconds i (+ (vector-ref seconds i) 1)))
    (for ([j (in-range i 60)])
      (vector-set! seconds j (+ (vector-ref seconds j) 1))))
  (for ([i (in-list I)])
    (mark-index i))
  (for ([i (in-range 60)])
    (when (> (vector-ref seconds i) 0)
      (return i)))
  -1)

(define (earliestSecond I)
  (earliest_second_to_mark_indices I))