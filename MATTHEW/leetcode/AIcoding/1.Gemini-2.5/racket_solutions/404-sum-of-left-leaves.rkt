(define-struct TreeNode (val left right))

(define (sum-of-left-leaves root)
  (if (null? root)
      0
      (+ (if (and (not (null? (TreeNode-left root)))
                  (null? (TreeNode-left (TreeNode-left root)))
                  (null? (TreeNode-right (TreeNode-left root))))
             (TreeNode-val (TreeNode-left root))
             0)
         (sum-of-left-leaves (TreeNode-left root))
         (sum-of-left-leaves (TreeNode-right root)))))