(struct TreeNode (val left right))

(define (flipEquiv root1 root2)
  (cond
    ((and (null? root1) (null? root2)) #t)
    ((or (null? root1) (null? root2)) #f)
    ((not (= (TreeNode-val root1) (TreeNode-val root2))) #f)
    (else
     (or
      (and (flipEquiv (TreeNode-left root1) (TreeNode-left root2))
           (flipEquiv (TreeNode-right root1) (TreeNode-right root2)))
      (and (flipEquiv (TreeNode-left root1) (TreeNode-right root2))
           (flipEquiv (TreeNode-right root1) (TreeNode-left root2)))))))