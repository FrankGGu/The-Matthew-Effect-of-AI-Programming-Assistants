(define-struct TreeNode (val left right))

(define (invertTree root)
  (if (not root)
      #f
      (let* ([left-inverted (invertTree (TreeNode-left root))]
             [right-inverted (invertTree (TreeNode-right root))])
        (TreeNode (TreeNode-val root) right-inverted left-inverted))))