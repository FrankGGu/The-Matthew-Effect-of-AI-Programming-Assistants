(define-struct TreeNode (val left right))

(define (min-depth root)
  (cond
    [(null? root) 0]
    [(and (null? (TreeNode-left root)) (null? (TreeNode-right root))) 1]
    [(null? (TreeNode-left root)) (+ 1 (min-depth (TreeNode-right root)))]
    [(null? (TreeNode-right root)) (+ 1 (min-depth (TreeNode-left root)))]
    [else (+ 1 (min (min-depth (TreeNode-left root)) (min-depth (TreeNode-right root))))]))