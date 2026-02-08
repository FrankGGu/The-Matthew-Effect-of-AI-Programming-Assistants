#lang racket

(define (max-ancestor-diff root)
  (define (helper node min-val max-val)
    (if (null? node)
        (- max-val min-val)
        (let* ((val (tree-value node))
               (new-min (min min-val val))
               (new-max (max max-val val)))
          (max (helper (left-child node) new-min new-max)
               (helper (right-child node) new-min new-max)))))
  (helper root (tree-value root) (tree-value root))
)

(define (tree-value node) (send node get-value))
(define (left-child node) (send node get-left))
(define (right-child node) (send node get-right))