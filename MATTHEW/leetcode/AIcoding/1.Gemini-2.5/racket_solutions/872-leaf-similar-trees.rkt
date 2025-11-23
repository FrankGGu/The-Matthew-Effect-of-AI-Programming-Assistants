(define-struct TreeNode (val left right))

(define (get-leaves root)
  (cond
    [(null? root) '()]
    [(and (null? (TreeNode-left root)) (null? (TreeNode-right root)))
     (list (TreeNode-val root))]
    [else
     (append (get-leaves (TreeNode-left root))
             (get-leaves (TreeNode-right root)))]))

(define (leaf-similar root1 root2)
  (equal? (get-leaves root1) (get-leaves root2)))