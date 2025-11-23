#lang racket

(struct TreeNode (val left right))

(define (isBalanced root)
  (define (height node)
    (if (null? node)
        0
        (let ((left-height (height (TreeNode-left node)))
              (right-height (height (TreeNode-right node))))
          (if (or (eq? left-height -1) (eq? right-height -1))
              -1
              (if (= (abs (- left-height right-height)) 1)
                  (+ 1 (max left-height right-height))
                  -1)))))
  (not (= (height root) -1)))