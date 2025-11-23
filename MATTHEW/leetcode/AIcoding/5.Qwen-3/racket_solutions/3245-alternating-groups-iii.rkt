#lang racket

(define (num-alternating-subarrays s)
  (define n (string-length s))
  (define dp (make-vector n 1))
  (for ([i (in-range 1 n)])
    (when (= (string-ref s (- i 1)) (string-ref s i))
      (vector-set! dp i (vector-ref dp (- i 1)))))
  (apply + (vector->list dp)))