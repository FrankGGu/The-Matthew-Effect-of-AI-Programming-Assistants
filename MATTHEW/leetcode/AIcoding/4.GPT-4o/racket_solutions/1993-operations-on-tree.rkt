(define (count-nodes root)
  (if (null? root)
      0
      (+ 1 (count-nodes (car root)) (count-nodes (cadr root)))))

(define (sum-nodes root)
  (if (null? root)
      0
      (+ (car root) (sum-nodes (car root)) (sum-nodes (cadr root)))))

(define (max-node root)
  (if (null? root)
      -inf.0
      (max (car root) (max (max-node (car root)) (max-node (cadr root))))))

(define (min-node root)
  (if (null? root)
      +inf.0
      (min (car root) (min (min-node (car root)) (min-node (cadr root))))))

(define (operations-on-tree root)
  (list (count-nodes root) (sum-nodes root) (max-node root) (min-node root)))