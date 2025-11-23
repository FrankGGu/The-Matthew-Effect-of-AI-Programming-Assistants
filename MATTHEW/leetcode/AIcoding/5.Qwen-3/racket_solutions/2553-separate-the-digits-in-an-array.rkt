#lang racket

(define (separate-digits nums)
  (define (split n)
    (if (= n 0)
        '()
        (append (split (quotient n 10)) (list (remainder n 10)))))
  (apply append (map split nums)))