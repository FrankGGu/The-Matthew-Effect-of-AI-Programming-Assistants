#lang racket

(define (rearrange-sticks n k)
  (define mod 1000000007)
  (define dp (make-vector (+ n 1) (make-vector (+ n 1) 0)))
  (vector-set! dp 0 0 1)
  (for ([i (in-range 1 (+ n 1))])
    (vector-set! dp i 1 1)
    (for ([j (in-range 2 (+ i 1))])
      (vector-set! dp i j (modulo (+ (vector-ref dp i j) (* (vector-ref dp (- i 1) (- j 1)) (if (= j 1) 1 (- i 1)))) mod))))
  (vector-ref (vector-ref dp n k) 0))