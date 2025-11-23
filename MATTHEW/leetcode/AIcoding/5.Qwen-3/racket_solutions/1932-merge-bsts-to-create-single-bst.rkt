#lang racket

(define (merge-bsts root1 root2)
  (define (inorder-traversal node result)
    (when node
      (inorder-traversal (node-left node) result)
      (set! result (cons (node-val node) result))
      (inorder-traversal (node-right node) result)))

  (define (sorted-list-to-bst lst)
    (cond [(null? lst) #f]
          [(null? (cdr lst)) (make-node (car lst) #f #f)]
          [else
           (let* ([mid (quotient (length lst) 2)]
                  [root (make-node (list-ref lst mid) #f #f)]
                  [left (sorted-list-to-bst (take lst mid))]
                  [right (sorted-list-to-bst (drop lst (add1 mid)))])
             (set-node-left! root left)
             (set-node-right! root right)
             root)]))

  (define lst1 '())
  (inorder-traversal root1 (box lst1))
  (define lst2 '())
  (inorder-traversal root2 (box lst2))
  (define merged (append lst1 lst2))
  (sorted-list-to-bst (sort merged <)))