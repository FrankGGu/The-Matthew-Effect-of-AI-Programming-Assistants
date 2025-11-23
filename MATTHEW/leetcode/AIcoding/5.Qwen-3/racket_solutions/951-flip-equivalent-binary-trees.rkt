#lang racket

(define-struct tree (val left right))

(define (flip-equivalent-binary-trees root1 root2)
  (cond [(and (not root1) (not root2)) #t]
        [(or (not root1) (not root2)) #f]
        [else
         (and (= (tree-val root1) (tree-val root2))
              (or (and (flip-equivalent-binary-trees (tree-left root1) (tree-left root2))
                       (flip-equivalent-binary-trees (tree-right root1) (tree-right root2)))
                  (and (flip-equivalent-binary-trees (tree-left root1) (tree-right root2))
                       (flip-equivalent-binary-trees (tree-right root1) (tree-left root2)))))]))