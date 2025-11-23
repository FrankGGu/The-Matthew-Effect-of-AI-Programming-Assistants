(define-struct TreeNode (val left right))

(define (deleteLeaves root target)
  (cond
    [(null? root) null]
    [else
     (define new-left (deleteLeaves (TreeNode-left root) target))
     (define new-right (deleteLeaves (TreeNode-right root) target))

     (define current-node (TreeNode (TreeNode-val root) new-left new-right))

     (if (and (null? (TreeNode-left current-node))
              (null? (TreeNode-right current-node))
              (= (TreeNode-val current-node) target))
         null
         current-node)]))