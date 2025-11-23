#lang racket

(define (sum-of-squares-subarrays nums)
  (define n (length nums))
  (define result 0)
  (define last (make-hash))
  (define dp (make-vector n 0))
  (for ([i (in-range n)])
    (define x (list-ref nums i))
    (define prev (hash-ref last x -1))
    (vector-set! dp i (+ (* (if (> prev -1) (vector-ref dp prev) 0) 2) 1))
    (hash-set! last x i)
    (set! result (+ result (vector-ref dp i))))
  result)