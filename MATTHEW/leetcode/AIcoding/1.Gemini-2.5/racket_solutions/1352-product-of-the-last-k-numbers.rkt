#lang racket

(define-struct product-of-numbers (products current-size))

(define (product-of-numbers-add! this num)
  (let ((products-vec (product-of-numbers-products this))
        (current-idx (product-of-numbers-current-size this)))
    (if (= num 0)
        (begin
          (vector-set! products-vec 0 1)
          (set-product-of-numbers-current-size! this 1))
        (begin
          (let ((last-product (vector-ref products-vec (- current-idx 1))))
            (vector-set! products-vec current-idx (* last-product num)))
          (set-product-of-numbers-current-size! this (+ current-idx 1))))))

(define (product-of-numbers-get-product this k)
  (let ((products-vec (product-of-numbers-products this))
        (current-idx (product-of-numbers-current-size this)))
    (if (>= k current-idx)
        0
        (/ (vector-ref products-vec (- current-idx 1))
           (vector-ref products-vec (- current-idx 1 k))))))

(define (product-of-numbers)
  (let ((initial-vec (make-vector 40001)))
    (vector-set! initial-vec 0 1)
    (make-product-of-numbers initial-vec 1)))