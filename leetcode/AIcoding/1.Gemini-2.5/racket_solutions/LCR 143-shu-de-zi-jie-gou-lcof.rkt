(struct TreeNode (val left right))

(define (isSubstructure A B)
  (cond
    [(or (not A) (not B)) #f]
    [else (or (check A B)
              (isSubstructure (TreeNode-left A) B)
              (isSubstructure (TreeNode-right A) B))]))

(define (check A B)
  (cond
    [(not B) #t]
    [(not A) #f]
    [(= (TreeNode-val A) (TreeNode-val B))
     (and (check (TreeNode-left A) (TreeNode-left B))
          (check (TreeNode-right A) (TreeNode-right B)))]
    [else #f]))