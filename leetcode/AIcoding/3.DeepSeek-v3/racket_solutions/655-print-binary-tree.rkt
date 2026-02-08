#lang racket

(define/contract (print-tree root)
  (-> (or/c null? tree-node?) (listof (listof string?)))
  (if (null? root)
      '()
      (let* ([height (get-height root)]
             [width (sub1 (expt 2 height))]
             [res (build-list height (λ (_) (make-list width "")))])
        (fill-tree root 0 0 (sub1 width) res)
        res)))

(define (get-height node)
  (if (null? node)
      0
      (add1 (max (get-height (tree-node-left node))
                 (get-height (tree-node-right node))))))

(define (fill-tree node row left right res)
  (when (not (null? node))
  (let* ([mid (quotient (+ left right) 2)]
         [current-row (list-ref res row)])
    (list-set! current-row mid (number->string (tree-node-val node)))
    (unless (null? (tree-node-left node))
      (fill-tree (tree-node-left node) (add1 row) left (sub1 mid) res))
    (unless (null? (tree-node-right node))
      (fill-tree (tree-node-right node) (add1 row) (add1 mid) right res))))

(define-struct tree-node (val left right) #:transparent)