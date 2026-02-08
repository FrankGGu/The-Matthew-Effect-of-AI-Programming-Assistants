#lang racket

(define (lowestCommonAncestor root p q)
  (cond
    [(< (send p 'val) (send root 'val) (send q 'val)) (lowestCommonAncestor (send root 'left) p q)]
    [(> (send p 'val) (send root 'val) (send q 'val)) (lowestCommonAncestor (send root 'right) p q)]
    [else root]))