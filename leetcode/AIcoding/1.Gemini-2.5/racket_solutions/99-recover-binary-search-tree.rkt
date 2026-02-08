(define-struct (TreeNode val left right) #:mutable)

(define (recoverTree root)
  (define prev (box #f))
  (define first (box #f))
  (define second (box #f))

  (define (inorder node)
    (when node
      (inorder (TreeNode-left node))

      (when (and (unbox prev) (< (TreeNode-val node) (TreeNode-val (unbox prev))))
        (when (not (unbox first))
          (set-box! first (unbox prev)))
        (set-box! second node))

      (set-box! prev node)

      (inorder (TreeNode-right node))))

  (inorder root)

  (when (unbox first)
    (define temp (TreeNode-val (unbox first)))
    (set-TreeNode-val! (unbox first) (TreeNode-val (unbox second)))
    (set-TreeNode-val! (unbox second) temp)))