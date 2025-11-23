#lang racket

(define (get-integer head)
  (define (iter node res)
    (if (not node)
        res
        (iter (cdr node) (+ (* res 2) (car node)))))
  (iter head 0))