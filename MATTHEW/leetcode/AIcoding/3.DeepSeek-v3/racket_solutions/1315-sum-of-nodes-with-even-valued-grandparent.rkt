#lang racket

(define (sum-even-grandparent root)
  (define (helper node parent grandparent)
    (if (null? node)
        0
        (+ (if (and (not (null? grandparent)) (even? (car grandparent)))
               (car node)
               0)
           (helper (cadr node) node parent)
           (helper (caddr node) node parent))))
  (helper root null null))