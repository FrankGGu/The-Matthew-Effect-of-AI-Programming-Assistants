#lang racket

(define (generate-parenthesis n)
  (define (backtrack current open-count close-count)
    (if (= (string-length current) (* 2 n))
        (list current)
        (append
         (if (< open-count n)
             (backtrack (string-append current "(") (+ open-count 1) close-count)
             '())
         (if (< close-count open-count)
             (backtrack (string-append current ")") open-count (+ close-count 1))
             '()))))
  (backtrack "" 0 0))