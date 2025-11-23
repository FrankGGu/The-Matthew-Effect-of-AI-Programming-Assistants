#lang racket

(define (special-array nums)
  (define (count-gte x)
    (length (filter (lambda (n) (>= n x)) nums)))
  (let loop ([x 0])
    (if (> x (length nums))
        -1
        (if (= (count-gte x) x)
            x
            (loop (+ x 1))))))