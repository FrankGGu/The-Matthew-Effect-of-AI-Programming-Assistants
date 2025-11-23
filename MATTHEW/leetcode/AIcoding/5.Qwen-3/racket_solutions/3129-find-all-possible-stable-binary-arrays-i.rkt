#lang racket

(define (stable-binary-arrays m k)
  (define (dfs path)
    (if (= (length path) m)
        (list path)
        (append
         (if (and (>= (length path) k) (equal? (take-right path k) (make-list k 1)))
             '()
             (dfs (append path (list 1))))
         (if (and (>= (length path) k) (equal? (take-right path k) (make-list k 0)))
             '()
             (dfs (append path (list 0)))))))
  (dfs '()))