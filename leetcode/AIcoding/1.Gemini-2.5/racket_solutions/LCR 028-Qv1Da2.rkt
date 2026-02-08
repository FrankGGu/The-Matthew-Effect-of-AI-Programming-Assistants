#lang racket/base

(struct node (val prev next child) #:mutable)

(define (flatten head)
  (define current head)
  (while current
    (when (node-child current)
      (let* ([next-node (node-next current)]
             [child-head (node-child current)])
        (define child-tail child-head)
        (while (node-next child-tail)
          (set! child-tail (node-next child-tail)))
        (set-node-next! current child-head)
        (set-node-prev! child-head current)
        (set-node-next! child-tail next-node)
        (when next-node
          (set-node-prev! next-node child-tail))
        (set-node-child! current #f)))
    (set! current (node-next current)))
  head)