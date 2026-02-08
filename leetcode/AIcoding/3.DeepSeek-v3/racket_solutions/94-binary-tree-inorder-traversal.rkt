(define/contract (inorder-traversal root)
  (-> (or/c null? tree-node?) (listof exact-integer?))
  (define (helper node acc)
    (if (null? node)
        acc
        (helper (tree-node-right node)
                (cons (tree-node-val node)
                      (helper (tree-node-left node) acc)))))
  (reverse (helper root '())))

(define-struct tree-node [val left right] #:transparent)