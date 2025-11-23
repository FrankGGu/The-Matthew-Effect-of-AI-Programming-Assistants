(define (longest-zig-zag root)
  (define max-length 0)

  (define (dfs node left-length right-length)
    (set! max-length (max max-length left-length right-length))
    (when (not (null? (node-left node)))
      (dfs (node-left node) 
           (if (null? (node-right node)) 1 (+ right-length 1))
           1))
    (when (not (null? (node-right node)))
      (dfs (node-right node) 
           1
           (if (null? (node-left node)) 1 (+ left-length 1)))))

  (if (null? root)
      0
      (begin
        (dfs root 0 0)
        max-length)))