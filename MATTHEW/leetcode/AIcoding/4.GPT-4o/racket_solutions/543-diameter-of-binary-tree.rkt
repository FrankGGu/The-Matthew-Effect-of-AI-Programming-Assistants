#lang racket

(struct TreeNode ([val : Integer] [left : (maybe TreeNode)] [right : (maybe TreeNode)]))

(define (diameterOfBinaryTree root)
  (define (dfs node)
    (if (null? node)
        (values 0 0)
        (let-values ([(left-diameter left-height) (dfs (tree-node-left node))]
                     [(right-diameter right-height) (dfs (tree-node-right node))])
          (values (max left-diameter right-diameter (add1 (+ left-height right-height)))
                  (add1 (max left-height right-height))))))
  (car (dfs root)))