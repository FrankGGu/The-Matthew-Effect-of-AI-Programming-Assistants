#lang racket

(define (min-moves-to-make-equal nums0 nums1 cost0 cost1)
  (define (abs x) (if (< x 0) (- x) x))
  (define (f x y c)
    (if (= x y) 0 (+ (* (abs (- x y)) c) 0)))
  (let ([a (map (lambda (x y) (f x y cost0)) nums0 nums1)]
        [b (map (lambda (x y) (f x y cost1)) nums0 nums1)])
    (apply + (map + a b))))