(define (goodNodes root)
  (define (count-good-nodes node max-so-far)
    (if (null? node)
        0
        (let* ((val (node-value node))
               (new-max (max val max-so-far))
               (is-good (if (>= val max-so-far) 1 0)))
          (+ is-good 
             (count-good-nodes (left child node) new-max) 
             (count-good-nodes (right child node) new-max)))))
  (count-good-nodes root (node-value root)))