#lang racket

(struct TreeNode (val left right) #:transparent)

(define (lcaDeepestLeaves root)
  (define-values (depth lca) (helper root))
  lca)

(define (helper node)
  (if (null? node)
      (values 0 #f)
      (let-values ([(ldepth lca-left) (helper (TreeNode-left node))]
                   [(rdepth lca-right) (helper (TreeNode-right node))])
        (cond
          ((= ldepth rdepth)
           (values (+ ldepth 1) node))
          ((> ldepth rdepth)
           (values (+ ldepth 1) lca-left))
          (else
           (values (+ rdepth 1) lca-right))))))