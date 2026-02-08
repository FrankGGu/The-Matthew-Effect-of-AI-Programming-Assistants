#lang racket
(require data/heap)
(require racket/hash)

(struct stock-price
  (prices
   latest-ts
   latest-price
   max-heap
   min-heap)
  #:mutable)

(define (stock-price-init)
  (stock-price (make-hash)
               0
               0
               (make-heap (lambda (p1 p2) (> (car p1) (car p2))))
               (make-heap (lambda (p1 p2) (< (car p1) (car p2))))))

(define (stock-price-update sp timestamp price)
  (hash-set! (stock-price-prices sp) timestamp price)

  (when (> timestamp (stock-price-latest-ts sp))
    (set-stock-price-latest-ts sp timestamp)
    (set-stock-price-latest-price sp price))

  (heap-add! (stock-price-max-heap sp) (cons price timestamp))
  (heap-add! (stock-price-min-heap sp) (cons price timestamp)))

(define (stock-price-current sp)
  (stock-price-latest-price sp))

(define (stock-price-maximum sp)
  (let loop ()
    (let* ((top-pair (heap-min (stock-price-max-heap sp)))
           (p (car top-pair))
           (ts (cdr top-pair)))
      (if (= p (hash-ref (stock-price-prices sp) ts #f))
          p
          (begin
            (heap-remove-min! (stock-price-max-heap sp))
            (loop))))))

(define (stock-price-minimum sp)
  (let loop ()
    (let* ((top-pair (heap-min (stock-price-min-heap sp)))
           (p (car top-pair))
           (ts (cdr top-pair)))
      (if (= p (hash-ref (stock-price-prices sp) ts #f))
          p
          (begin
            (heap-remove-min! (stock-price-min-heap sp))
            (loop))))))