#lang racket

(define (reachable? x y)
  (let loop ([x x] [y y])
    (cond [(and (= x 0) (= y 0)) #t]
          [(or (< x 0) (< y 0)) #f]
          [else (loop (- x y) y)])))