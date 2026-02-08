(define (is-symmetric root)
  (cond
    [(null? root) #t]
    [else (is-mirror (TreeNode-left root) (TreeNode-right root))]))

(define (is-mirror t1 t2)
  (cond
    [(and (null? t1) (null? t2)) #t]
    [(or (null? t1) (null? t2)) #f]
    [else
     (and
      (equal? (TreeNode-val t1) (TreeNode-val t2))
      (is-mirror (TreeNode-left t1) (TreeNode-right t2))
      (is-mirror (TreeNode-right t1) (TreeNode-left t2)))]))