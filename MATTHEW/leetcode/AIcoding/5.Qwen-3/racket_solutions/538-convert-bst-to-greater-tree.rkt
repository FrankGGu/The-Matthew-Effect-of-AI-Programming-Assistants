#lang racket

(define (convert-bst-to-greater-tree root)
  (define sum 0)
  (define (traverse node)
    (when node
      (traverse (node-right node))
      (set! sum (+ sum (node-val node)))
      (set! (node-val node) sum)
      (traverse (node-left node))))
  (traverse root)
  root)

(define-struct node (val left right))