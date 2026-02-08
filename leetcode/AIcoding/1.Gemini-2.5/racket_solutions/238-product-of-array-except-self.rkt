#lang racket

(define (product-except-self nums)
  (define n (vector-length nums))
  (define answer (make-vector n 1))

  (for ([i (in-range 1 n)])
    (vector-set! answer i (* (vector-ref answer (- i 1)) (vector-ref nums (- i 1)))))

  (define right-product 1)
  (for ([i (in-range (- n 1) -1 -1)])
    (vector-set! answer i (* (vector-ref answer i) right-product))
    (set! right-product (* right-product (vector-ref nums i))))

  answer)