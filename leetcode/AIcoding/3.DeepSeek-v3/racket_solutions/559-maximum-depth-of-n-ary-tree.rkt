(define (max-depth root)
  (if (null? root)
      0
      (let loop ([nodes (list root)] [depth 0])
        (if (null? nodes)
            depth
            (loop (append-map (lambda (node) (node-children node)) nodes) 
                 (+ depth 1))))))