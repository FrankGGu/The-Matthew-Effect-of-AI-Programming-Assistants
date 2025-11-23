#lang racket

(define (min-operations target-array source-array)
  (define (count-ops s t)
    (cond [(= s t) 0]
          [(> s t) (add1 (count-ops (- s 1) t))]
          [else (add1 (count-ops s (+ t 1)))]))
  (define (helper s t)
    (if (null? s)
        0
        (+ (count-ops (car s) (car t)) (helper (cdr s) (cdr t)))))
  (helper target-array source-array))