#lang racket

#|
|#
(define-struct TreeNode (val left right) #:transparent)

(define (reverse-odd-levels root)
  (define (reverse-helper nodes level)
    (if (null? nodes)
        null
        (let* ([vals (if (odd? level)
                         (reverse (map TreeNode-val nodes))
                         (map TreeNode-val nodes))]
               [next-nodes (append-map (λ (n) (filter identity (list (TreeNode-left n) (TreeNode-right n)))) nodes)]
               [children (reverse-helper next-nodes (add1 level))])
          (if (odd? level)
              (for/list ([val vals] [left (take children (length vals))] [right (drop children (length vals))])
                (make-TreeNode val left right))
              (for/list ([val vals] [left (take children (length vals))] [right (drop children (length vals))])
                (make-TreeNode val left right))))))
  (if (not root)
      root
      (car (reverse-helper (list root) 0))))