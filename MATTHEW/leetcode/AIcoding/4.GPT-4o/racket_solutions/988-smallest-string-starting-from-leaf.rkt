#lang racket

(define (smallest-from-leaf root)
  (define (dfs node)
    (if (null? node)
        '()
        (let* ((val (char->integer (char->string (tree-node-value node))))
               (left (dfs (tree-left node)))
               (right (dfs (tree-right node)))
               (smallest (if (null? left)
                             right
                             (if (null? right)
                                 left
                                 (if (string<? left right)
                                     left
                                     right)))))
          (if (null? smallest)
              (string (integer->char val))
              (string-append (string (integer->char val)) smallest)))))
  (let ((result (dfs root)))
    (if (null? result)
        ""
        (string-append result ""))))

(define (tree-node-value node) (node-value node))
(define (tree-left node) (left node))
(define (tree-right node) (right node))