(struct Node (val children))

(define (max-depth root)
  (if (null? root)
      0
      (+ 1 (if (null? (Node-children root))
               0
               (apply max (map max-depth (Node-children root)))))))