#lang racket

(define/contract (func)
  (-> exact-integer?)
  (let* ([n (read)]
         [lines (make-vector 1 0)]
         [chars (make-hash)])
    (for ([i (in-range n)])
      (let ([c (string-ref (read) 0)])
        (hash-set! chars c (+ 1 (hash-ref chars c 0)))))
    (for ([c (in-hash-keys chars)])
      (let ([cnt (hash-ref chars c)])
        (vector-set! lines 0 (+ (vector-ref lines 0) (quotient cnt 2)))))
    (vector-ref lines 0)))