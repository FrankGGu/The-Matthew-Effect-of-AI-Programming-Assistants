#lang racket

(define (color-bst root color)
  (if (null? root)
      '()
      (append (color-bst (tree-left root) color)
              (list (list (tree-val root) color))
              (color-bst (tree-right root) color))))

(define (color-bst-main root)
  (color-bst root 'red))