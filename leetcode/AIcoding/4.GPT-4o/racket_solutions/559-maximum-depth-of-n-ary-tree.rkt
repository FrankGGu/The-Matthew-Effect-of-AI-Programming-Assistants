(struct Node (val children))

(define (maxDepth root)
  (if (null? root)
      0
      (add1 (apply max (map maxDepth (Node-children root)) 0))))