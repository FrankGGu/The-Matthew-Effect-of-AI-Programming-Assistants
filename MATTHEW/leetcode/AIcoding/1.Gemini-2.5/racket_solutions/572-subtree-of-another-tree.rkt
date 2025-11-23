(struct TreeNode (val left right) #:transparent)

(define (is-same-tree? p q)
  (cond
    [(and (null? p) (null? q)) #t]
    [(or (null? p) (null? q)) #f]
    [else
     (and (= (TreeNode-val p) (TreeNode-val q))
          (is-same-tree? (TreeNode-left p) (TreeNode-left q))
          (is-same-tree? (TreeNode-right p) (TreeNode-right q)))]))

(define (is-subtree? s t)
  (cond
    [(null? t) #t]
    [(null? s) #f]
    [else
     (or (is-same-tree? s t)
         (is-subtree? (TreeNode-left s) t)
         (is-subtree? (TreeNode-right s) t))]))