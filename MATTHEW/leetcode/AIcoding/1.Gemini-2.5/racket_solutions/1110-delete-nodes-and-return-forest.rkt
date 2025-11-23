#lang racket

(struct TreeNode (val left right) #:mutable)

(require racket/hash)

(define (del-nodes root to-delete)
  (define to-delete-set (list->hash-set to-delete))
  (define forest-roots '())

  (define (dfs node)
    (unless node #f)

    (set-tree-node-left! node (dfs (tree-node-left node)))
    (set-tree-node-right! node (dfs (tree-node-right node)))

    (if (hash-set-member? to-delete-set (tree-node-val node))
        (begin
          (when (tree-node-left node)
            (set! forest-roots (cons (tree-node-left node) forest-roots)))
          (when (tree-node-right node)
            (set! forest-roots (cons (tree-node-right node) forest-roots)))
          #f)
        node))

  (define final-root (dfs root))

  (when final-root
    (set! forest-roots (cons final-root forest-roots)))

  (reverse forest-roots))