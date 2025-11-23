#lang racket

(struct TreeNode (val left right))

(define max-path 0)

(define (longest-zigzag-path root)
  (set! max-path 0)
  (dfs root)
  max-path)

(define (dfs node)
  (if (not node)
      (list -1 -1)
      (let* ((left-res (dfs (TreeNode-left node)))
             (right-res (dfs (TreeNode-right node)))
             (left-path-from-node (+ 1 (cadr left-res)))
             (right-path-from-node (+ 1 (car right-res))))
        (set! max-path (max max-path left-path-from-node right-path-from-node))
        (list left-path-from-node right-path-from-node))))