#lang racket

(define (max-non-overlapping-substrings s words)
  (define word-set (set->hash (apply set words)))
  (define n (string-length s))
  (define dp (make-vector n #f))
  (define res 0)

  (define (check i j)
    (and (<= j n)
         (set-member? word-set (substring s i j))))

  (for ([i (in-range n)])
    (when (check i (+ i 1))
      (vector-set! dp i #t)
      (set! res (+ res 1)))
    (when (and (> i 0) (vector-ref dp (- i 1)) (check (- i 1) i))
      (vector-set! dp i #t)
      (set! res (+ res 1))))

  res)