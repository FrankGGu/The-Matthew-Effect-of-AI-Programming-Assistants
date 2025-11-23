(define/struct TreeNode (val left right))
(define/struct Node (val prev next))

(define (tree-to-doubly-list root)
  (define (inorder node)
    (if (null? node)
        '()
        (append (inorder (tree-node-left node))
                (list (make-node (tree-node-val node)))
                (inorder (tree-node-right node)))))

  (define nodes (inorder root))

  (if (null? nodes)
      (void)
      (begin
        (for-each (lambda (n)
                    (set! (node-next n) (if (null? (cdr nodes)) '() (cadr nodes)))
                    (set! (node-prev (cadr nodes)) n))
                  (butlast nodes))
        (set! (node-prev (car nodes)) (last nodes))
        (set! (node-next (last nodes)) (car nodes))
        (car nodes))))