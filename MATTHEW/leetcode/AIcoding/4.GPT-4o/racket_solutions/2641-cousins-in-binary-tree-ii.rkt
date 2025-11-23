#lang racket

(define-struct TreeNode (val left right))

(define (cousinsInBinaryTree root)
  (define (dfs node depth parent)
    (if (null? node)
        '()
        (cons (list node depth parent)
              (append (dfs (TreeNode-left node) (+ depth 1) node)
                      (dfs (TreeNode-right node) (+ depth 1) node)))))
  (define nodes (dfs root 0 #f))
  (define groups (group-by second nodes))
  (define (process-group group)
    (map first group))
  (map process-group (filter (lambda (g) (= (length g) 2)) groups)))