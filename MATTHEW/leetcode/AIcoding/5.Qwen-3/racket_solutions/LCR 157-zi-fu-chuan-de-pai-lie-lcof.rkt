#lang racket

(define (num-possible-ways n)
  (define (helper i res)
    (if (> i n)
        res
        (helper (+ i 1) (+ res (* i i)))))
  (helper 1 0))