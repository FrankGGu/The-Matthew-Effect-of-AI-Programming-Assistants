#lang racket

(define (num-arrays s)
  (define n (string-length s))
  (define cnt (make-vector 2 0))
  (define (update i)
    (vector-set! cnt (modulo i 2) (+ (vector-ref cnt (modulo i 2)) 1)))
  (for ([i (in-range n)])
    (when (or (= i 0) (not (= (string-ref s (sub1 i)) (string-ref s i))))
      (update i)))
  (let ([a (vector-ref cnt 0)]
        [b (vector-ref cnt 1)])
    (* a b)))