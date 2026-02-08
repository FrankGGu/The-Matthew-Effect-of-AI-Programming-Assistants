#lang racket

(define (all-elements-in-two-binary-search-trees root1 root2)
  (define (in-order-traversal root)
    (if (null? root)
        '()
        (append (in-order-traversal (car root))
                (list (cadr root))
                (in-order-traversal (caddr root)))))
  (let ((lst1 (in-order-traversal root1))
        (lst2 (in-order-traversal root2)))
    (sort (append lst1 lst2) <)))