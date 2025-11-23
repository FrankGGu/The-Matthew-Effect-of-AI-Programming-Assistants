(struct TreeNode (val left right))

(define (find-min node)
  (if (null? (TreeNode-left node))
      node
      (find-min (TreeNode-left node))))

(define (delete-node root key)
  (cond
    [(null? root) null]
    [(< key (TreeNode-val root))
     (TreeNode (TreeNode-val root)
               (delete-node (TreeNode-left root) key)
               (TreeNode-right root))]
    [(> key (TreeNode-val root))
     (TreeNode (TreeNode-val root)
               (TreeNode-left root)
               (delete-node (TreeNode-right root) key))]
    [else
     (cond
       [(null? (TreeNode-left root))
        (TreeNode-right root)]
       [(null? (TreeNode-right root))
        (TreeNode-left root)]
       [else
        (define successor (find-min (TreeNode-right root)))
        (TreeNode (TreeNode-val successor)
                  (TreeNode-left root)
                  (delete-node (TreeNode-right root) (TreeNode-val successor)))]
       )]))