(struct TreeNode (val left right))

(define (search-bst root val)
  (cond
    [(null? root) #f]
    [(= (TreeNode-val root) val) root]
    [(< val (TreeNode-val root)) (search-bst (TreeNode-left root) val)]
    [else (search-bst (TreeNode-right root) val)]))