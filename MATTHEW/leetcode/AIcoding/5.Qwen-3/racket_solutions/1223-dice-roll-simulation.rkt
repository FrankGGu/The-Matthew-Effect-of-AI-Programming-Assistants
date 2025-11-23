#lang racket

(define (num-rolls-to-equilibrium n)
  (define mod 1000000007)
  (define dp (make-vector (+ n 1) 0))
  (vector-set! dp 0 1)
  (for ([i (in-range 1 (+ n 1))])
    (for ([j (in-range 1 7)])
      (when (<= j i)
        (vector-set! dp i (modulo (+ (vector-ref dp i) (vector-ref dp (- i j))) mod)))))
  (vector-ref dp n))