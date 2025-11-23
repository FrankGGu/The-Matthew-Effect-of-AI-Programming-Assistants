(define-struct TreeNode (val left right))

(define (inorder-successor root p)
  (define (helper node successor)
    (cond
      [(null? node) successor]
      [(< (TreeNode-val node) (TreeNode-val p))
       (helper (TreeNode-right node) successor)]
      [else (helper (TreeNode-left node) node)]))
  (define successor (helper root null))
  (if (null? successor)
      null
      successor))