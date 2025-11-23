(struct TreeNode (val left right) #:transparent)

(define (merge-trees t1 t2)
  (cond
    [(and (null? t1) (null? t2))
     null]
    [(null? t1)
     t2]
    [(null? t2)
     t1]
    [else
     (TreeNode (+ (TreeNode-val t1) (TreeNode-val t2))
               (merge-trees (TreeNode-left t1) (TreeNode-left t2))
               (merge-trees (TreeNode-right t1) (TreeNode-right t2)))]))