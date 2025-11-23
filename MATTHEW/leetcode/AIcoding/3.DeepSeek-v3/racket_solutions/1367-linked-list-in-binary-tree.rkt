#lang racket

(define (is-sub-path head root)
  (define (dfs-linked-list node tree-node)
    (cond
      [(null? node) #t]
      [(null? tree-node) #f]
      [(= (car node) (tree-node-val tree-node))
       (or (dfs-linked-list (cdr node) (tree-node-left tree-node))
           (dfs-linked-list (cdr node) (tree-node-right tree-node)))]
      [else #f]))

  (define (dfs-tree tree-node)
    (cond
      [(null? tree-node) #f]
      [(dfs-linked-list head tree-node) #t]
      [else (or (dfs-tree (tree-node-left tree-node))
                (dfs-tree (tree-node-right tree-node)))]))

  (dfs-tree root))

(define-struct list-node (val next) #:transparent)

(define-struct tree-node (val left right) #:transparent)