(define (pathSum root sum)
  (define (countPaths node currentSum)
    (if (null? node)
        0
        (+ (if (= (val node) currentSum) 1 0)
           (countPaths (left node) (- currentSum (val node)))
           (countPaths (right node) (- currentSum (val node))))))

  (define (dfs node)
    (if (null? node)
        0
        (+ (countPaths node sum)
           (dfs (left node))
           (dfs (right node)))))

  (dfs root))