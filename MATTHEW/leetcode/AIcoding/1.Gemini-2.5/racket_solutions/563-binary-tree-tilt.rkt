#lang racket

(struct TreeNode (val left right))

(define (find-tilt root)
  (define (helper node)
    (if (null? node)
        (cons 0 0) ; (sum-of-subtree . total-tilt-of-subtree)
        (let* ([left-result (helper (TreeNode-left node))]
               [right-result (helper (TreeNode-right node))]
               [left-sum (car left-result)]
               [left-tilt (cdr left-result)]
               [right-sum (car right-result)]
               [right-tilt (cdr right-result)]
               [current-node-tilt (abs (- left-sum right-sum))]
               [total-subtree-tilt (+ left-tilt right-tilt current-node-tilt)]
               [total-subtree-sum (+ left-sum right-sum (TreeNode-val node))])
          (cons total-subtree-sum total-subtree-tilt))))
  (cdr (helper root)))