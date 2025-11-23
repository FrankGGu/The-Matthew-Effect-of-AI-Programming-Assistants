(define (add-one-row root v d)
  (cond
    [(null? root) null]
    [(= d 1) (let ([new-node (TreeNode v)])
               (set-TreeNode-left! new-node root)
               new-node)]
    [(= d 2) (let ([left (TreeNode-left root)]
                  [right (TreeNode-right root)])
               (set-TreeNode-left! root (TreeNode v))
               (set-TreeNode-left! (TreeNode-left root) left)
               (set-TreeNode-right! root (TreeNode v))
               (set-TreeNode-right! (TreeNode-right root) right)
               root)]
    [else (begin
            (set-TreeNode-left! root (add-one-row (TreeNode-left root) v (- d 1)))
            (set-TreeNode-right! root (add-one-row (TreeNode-right root) v (- d 1)))
            root)]))