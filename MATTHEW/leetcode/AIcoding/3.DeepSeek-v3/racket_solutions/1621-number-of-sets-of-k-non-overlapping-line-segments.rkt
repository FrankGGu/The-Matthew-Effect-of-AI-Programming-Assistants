#lang racket

(define (number-of-sets n k)
  (define mod 1000000007)
  (define dp (make-vector (add1 k) (make-vector (add1 n) 0)))
  (for ([i (in-range 1 (add1 n))])
    (vector-set! (vector-ref dp 0) i 1))
  (for ([i (in-range 1 (add1 k))])
    (for ([j (in-range 1 (add1 n))])
      (vector-set! (vector-ref dp i) j 
                   (modulo (+ (vector-ref (vector-ref dp i) (sub1 j))
                            (vector-ref (vector-ref dp (sub1 i)) (sub1 j))
                            mod))))
  (vector-ref (vector-ref dp k) n))