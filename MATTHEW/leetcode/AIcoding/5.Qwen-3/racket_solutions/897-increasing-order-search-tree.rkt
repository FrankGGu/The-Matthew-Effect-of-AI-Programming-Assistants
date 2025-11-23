#lang racket

(define (increasing-order-search-tree root)
  (define (inorder node result)
    (if (not node)
        result
        (begin
          (inorder (node-left node) result)
          (set-node-right! node #f)
          (set-node-left! node #f)
          (if (null? result)
              (begin
                (set! result (list node))
                (inorder (node-right node) result))
              (begin
                (set-cdr! (last-pair result) (list node))
                (inorder (node-right node) (last-pair result))))))
    result)
  (define (last-pair lst)
    (if (null? (cdr lst))
        lst
        (last-pair (cdr lst))))
  (if (not root)
      #f
      (let ((result (inorder root '())))
        (if (null? result)
            #f
            (car result)))))