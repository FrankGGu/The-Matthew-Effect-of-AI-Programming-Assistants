#lang racket

(define (can-reach-corner x y)
  (let loop ([a 0] [b 0])
    (cond [(or (= a x) (= b y)) #t]
          [(or (> a x) (> b y)) #f]
          [else
           (if (< a b)
               (loop (+ a 1) b)
               (loop a (+ b 1)))])))