#lang racket

(define (clone-graph node)
  (define visited (make-hash))
  (define (clone node)
    (cond
      [(not node) node]
      [(hash-has-key? visited node) (hash-ref visited node)]
      [else
       (define new-node (make-node (node-val node)))
       (hash-set! visited node new-node)
       (for-each (lambda (neighbor)
                   (set-node-neighbors! new-node (cons (clone neighbor) (node-neighbors new-node))))
                 (node-neighbors node))
       new-node]))
  (clone node))

(define-struct node (val neighbors) #:mutable)