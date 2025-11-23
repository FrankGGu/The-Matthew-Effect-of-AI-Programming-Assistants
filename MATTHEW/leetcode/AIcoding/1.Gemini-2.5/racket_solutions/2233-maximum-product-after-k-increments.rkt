#lang racket

(require data/heap)

(define (maximum-product nums k)
  (define mod 1000000007)
  (define (heap-compare x y) (< x y)) ; Min-heap

  (define h (make-heap heap-compare))

  (for-each (lambda (n) (heap-add! h n)) nums)

  (for ([_ (in-range k)])
    (define min-val (heap-min h))
    (heap-remove-min! h)
    (heap-add! h (+ min-val 1)))

  (define product 1)
  (for ([_ (in-range (heap-size h))])
    (define val (heap-min h))
    (heap-remove-min! h)
    (set! product (modulo (* product val) mod)))

  product)