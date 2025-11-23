#lang racket

(define (findMinimumTime time, move)
  (define n (length time))
  (define dp (make-vector n +inf.0))
  (vector-set! dp 0 0)

  (for ([i (in-range n)])
    (for ([j (in-range (max 0 (- i move))) (in-range (min n (+ i move 1)))])
      (vector-set! dp j (min (vector-ref dp j) (+ (vector-ref dp i) (vector-ref time j))))))

  (vector-ref dp (- n 1)))

(define (findMinimumTimeHandler time move)
  (findMinimumTime time move))