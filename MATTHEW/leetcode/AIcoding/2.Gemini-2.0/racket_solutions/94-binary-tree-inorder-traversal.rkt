(define (inorderTraversal root)
  (define (helper node acc)
    (cond [(null? node) acc]
          [else (helper (binary-tree-node-left node)
                        (cons (binary-tree-node-val node)
                              (helper (binary-tree-node-right node) acc)))]))
  (reverse (helper root '())))

(provide inorderTraversal)