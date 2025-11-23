#lang racket

(define MOD 1000000007)

(define (rearrange-sticks n k)
  (define dp (make-vector (add1 n) (make-vector (add1 k) 0)))
  (vector-set! (vector-ref dp 0) 0 1)
  (for ([i (in-range 1 (add1 n))])
    (for ([j (in-range 1 (add1 (min i k)))])
      (vector-set! (vector-ref dp i) j
                   (modulo (+ (* (sub1 i) (vector-ref (vector-ref dp (sub1 i)) j))
                              (vector-ref (vector-ref dp (sub1 i)) (sub1 j)))
                           MOD))))
    (when (<= i k)
      (vector-set! (vector-ref dp i) i 1)))
  (vector-ref (vector-ref dp n) k))