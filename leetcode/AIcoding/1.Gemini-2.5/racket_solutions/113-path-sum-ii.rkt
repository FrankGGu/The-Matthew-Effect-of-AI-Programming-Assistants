(struct TreeNode (val left right))

(define (path-sum root targetSum)
  (define (dfs node current-target current-path-reversed)
    (cond
      [(null? node) '()] ; If node is null, no paths can be formed from here
      [else
       (define node-val (TreeNode-val node))
       (define new-current-path-reversed (cons node-val current-path-reversed))
       (define remaining-target (- current-target node-val))

       (cond
         ;; If it's a leaf node
         [(and (null? (TreeNode-left node)) (null? (TreeNode-right node)))
          (if (= remaining-target 0)
              (list (reverse new-current-path-reversed)) ; Found a path, reverse it to get correct order
              '())] ; Not a valid path if remaining-target is not 0
         ;; If not a leaf, recurse on children
         [else
          (append
           (dfs (TreeNode-left node) remaining-target new-current-path-reversed)
           (dfs (TreeNode-right node) remaining-target new-current-path-reversed))])]))

  (dfs root targetSum '()))