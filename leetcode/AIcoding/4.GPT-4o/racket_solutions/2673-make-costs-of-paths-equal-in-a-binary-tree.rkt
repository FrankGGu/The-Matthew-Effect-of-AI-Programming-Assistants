(define (min-cost root)
  (define (dfs node)
    (if (null? node)
        (values 0 0)
        (let-values ([(left-cost left-count) (dfs (tree-left node))]
                     [(right-cost right-count) (dfs (tree-right node))])
          (define total-count (+ left-count right-count 1))
          (define total-cost (+ left-cost right-cost (tree-val node)))
          (values total-cost total-count))))
  (define-values (total-cost total-count) (dfs root))
  (define target (/ total-cost total-count))
  (define (dfs2 node)
    (if (null? node)
        0
        (let-values ([(left-diff) (dfs2 (tree-left node))]
                     [(right-diff) (dfs2 (tree-right node))])
          (+ left-diff right-diff (abs (- (tree-val node) target))))))
  (dfs2 root))