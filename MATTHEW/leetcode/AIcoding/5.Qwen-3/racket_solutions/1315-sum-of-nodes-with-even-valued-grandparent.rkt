#lang racket

(define (sum-even-grandparent root)
  (define (helper node parent grand-parent sum)
    (if (not node)
        sum
        (let ([current (if (and grand-parent (= (remainder (car grand-parent) 2) 0))
                           (+ sum (car node))
                           sum)])
          (helper (cadr node) (cons (car node) parent) parent current)
          (helper (caddr node) (cons (car node) parent) parent current))))
  (helper root '() '() 0))