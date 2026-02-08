(define (find-target root k)
  (let ((seen (mutable-set)))
    (define (dfs node)
      (if (not node)
          #f
          (let ((complement (- k (node-val node))))
            (if (set-member? seen complement)
                #t
                (begin
                  (set-add! seen (node-val node))
                  (or (dfs (node-left node))
                      (dfs (node-right node))))))))
    (dfs root)))