#lang racket

(define (largestValues root)
  (define (helper node level result)
    (if (null? node)
        result
        (let* ((val (first (node-value node)))
               (current-max (if (< level (length result))
                                (max val (list-ref result level))
                                val))
               (next-result (if (< level (length result))
                                result
                                (append result (list val)))))
          (helper (node-left node) level next-result)
          (helper (node-right node) (+ level 1) next-result))))
  (helper root 0 '()))

(define (node-value node) (if node (node-value node) 0))
(define (node-left node) (if node (node-left node) '()))
(define (node-right node) (if node (node-right node) '()))