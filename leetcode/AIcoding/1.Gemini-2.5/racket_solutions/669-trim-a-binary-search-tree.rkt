(define-struct TreeNode (val left right))

(define (trim-bst root low high)
  (cond
    [(null? root) null]
    [(< (TreeNode-val root) low)
     (trim-bst (TreeNode-right root) low high)]
    [(> (TreeNode-val root) high)
     (trim-bst (TreeNode-left root) low high)]
    [else
     (struct-copy TreeNode root
                   [left (trim-bst (TreeNode-left root) low high)]
                   [right (trim-bst (TreeNode-right root) low high)])]))