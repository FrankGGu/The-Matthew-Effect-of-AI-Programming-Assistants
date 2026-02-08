(define (pathSum root target)
  (define (dfs node sum)
    (if (null? node) 
        0
        (let* ((new-sum (+ sum (tree-val node)))
               (is-target (if (= new-sum target) 1 0))
               (left-paths (dfs (left node) new-sum))
               (right-paths (dfs (right node) new-sum)))
          (+ is-target left-paths right-paths))))

  (define (countPaths node)
    (if (null? node)
        0
        (+ (dfs node 0)
           (countPaths (left node))
           (countPaths (right node)))))

  (countPaths root))