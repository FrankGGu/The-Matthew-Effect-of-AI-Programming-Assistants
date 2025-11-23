(define/contract (find-target root k)
  (-> (or/c null? TreeNode?) exact-integer? boolean?)
  (let ([seen (mutable-set)])
    (define (dfs node)
      (if (null? node)
          #f
          (let ([complement (- k (TreeNode-val node))])
            (if (set-member? seen complement)
                #t
                (begin
                  (set-add! seen (TreeNode-val node))
                  (or (dfs (TreeNode-left node))
                      (dfs (TreeNode-right node))))))))
    (dfs root)))