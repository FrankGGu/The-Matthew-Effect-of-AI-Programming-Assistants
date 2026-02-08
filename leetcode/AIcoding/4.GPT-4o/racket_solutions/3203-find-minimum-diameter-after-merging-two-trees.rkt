#lang racket

(define (findDiameter root1 root2 m)
  (define (merge-trees t1 t2)
    (cond
      [(null? t1) t2]
      [(null? t2) t1]
      [else (make-node (+ (node-value t1) (node-value t2))
                       (merge-trees (left t1) (left t2))
                       (merge-trees (right t1) (right t2)))]))

  (define (diameter tree)
    (define (dfs node)
      (if (null? node)
          (values 0 0)
          (define-values (left-height left-diameter) (dfs (left node)))
          (define-values (right-height right-diameter) (dfs (right node)))
          (values (+ 1 (max left-height right-height))
                  (max left-diameter
                       right-diameter
                       (+ left-height right-height)))))
    (define-values (_ max-d) (dfs tree))
    max-d)

  (define merged-root (merge-trees root1 root2))
  (diameter merged-root))