#lang racket

(define (balance-bst root)
  (define (inorder-traversal node)
    (if (not node)
        '()
        (append (inorder-traversal (node-left node))
                (list node)
                (inorder-traversal (node-right node)))))

  (define (sorted-list-to-bst lst)
    (cond [(null? lst) #f]
          [(null? (cdr lst)) (car lst)]
          [else
           (let* ([mid (quotient (length lst) 2)]
                  [root (list-ref lst mid)]
                  [left (sorted-list-to-bst (take lst mid))]
                  [right (sorted-list-to-bst (drop lst (add1 mid)))])
             (set-node-left! root left)
             (set-node-right! root right)
             root)]))

  (sorted-list-to-bst (inorder-traversal root)))

(define-struct node (val left right) #:mutable)