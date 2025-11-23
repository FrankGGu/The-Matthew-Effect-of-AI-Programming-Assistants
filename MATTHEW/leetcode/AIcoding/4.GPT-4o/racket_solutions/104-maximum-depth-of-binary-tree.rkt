(define (maxDepth root)
  (if (null? root)
      0
      (+ 1 (max (maxDepth (tree-left root)) (maxDepth (tree-right root))))))