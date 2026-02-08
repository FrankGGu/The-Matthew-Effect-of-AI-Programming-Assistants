#lang racket

(define (kth-smallest root k)
  (define (inorder node acc)
    (if (null? node)
        acc
        (inorder (node-left node) (cons (node-val node) (inorder (node-right node) acc)))))
  (define sorted (inorder root '()))
  (list-ref (reverse sorted) (- (length sorted) k)))

(struct node (val left right))