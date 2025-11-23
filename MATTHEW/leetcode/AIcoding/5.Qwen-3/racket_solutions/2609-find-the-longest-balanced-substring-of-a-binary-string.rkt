#lang racket

(define (longest-balanced-substring s)
  (define len (string-length s))
  (define dp (make-vector len 0))
  (for ([i (in-range 1 len)])
    (when (and (= (string-ref s (sub1 i)) #\0)
               (= (string-ref s i) #\1))
      (vector-set! dp i (+ (vector-ref dp (sub1 i)) 2))))
  (apply max (vector->list dp)))