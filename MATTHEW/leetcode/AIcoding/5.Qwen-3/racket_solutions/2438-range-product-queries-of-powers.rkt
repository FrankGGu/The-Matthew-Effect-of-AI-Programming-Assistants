#lang racket

(define (range-product-queries nums queries)
  (define MOD 1000000007)
  (define n (length nums))
  (define prefix (make-vector (+ n 1) 1))
  (for ([i (in-range n)])
    (vector-set! prefix (+ i 1) (modulo (* (vector-ref prefix i) (list-ref nums i)) MOD)))
  (define (query l r)
    (modulo (/ (vector-ref prefix (+ r 1)) (vector-ref prefix l)) MOD))
  (map query queries))