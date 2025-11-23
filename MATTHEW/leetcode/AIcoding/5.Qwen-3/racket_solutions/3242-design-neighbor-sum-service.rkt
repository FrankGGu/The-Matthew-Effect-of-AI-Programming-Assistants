#lang racket

(define (make-neighbor-sum-service grid)
  (define rows (length grid))
  (define cols (if (> rows 0) (length (car grid)) 0))
  (define grid-ref (lambda (i j) (list-ref (list-ref grid i) j)))
  (define (sum-neighbor i j)
    (define-values (up down left right) (values (- i 1) (+ i 1) (- j 1) (+ j 1)))
    (define (valid? x y) (and (>= x 0) (< x rows) (>= y 0) (< y cols)))
    (define (get-value x y)
      (if (valid? x y) (grid-ref x y) 0))
    (+ (get-value up j) (get-value down j) (get-value i left) (get-value i right)))
  (lambda (i j) (sum-neighbor i j)))