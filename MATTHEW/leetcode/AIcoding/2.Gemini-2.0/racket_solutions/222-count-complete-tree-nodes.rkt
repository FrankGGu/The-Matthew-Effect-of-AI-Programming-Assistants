(define (count-nodes root)
  (cond
    [(null? root) 0]
    [else
     (define left-height (λ (node)
                            (cond
                              [(null? node) 0]
                              [else (+ 1 (left-height (struct-ref node 0)))])))
     (define right-height (λ (node)
                             (cond
                               [(null? node) 0]
                               [else (+ 1 (right-height (struct-ref node 1)))])))
     (define lh (left-height root))
     (define rh (right-height root))
     (if (= lh rh)
         (- (expt 2 lh) 1)
         (+ 1 (count-nodes (struct-ref root 0)) (count-nodes (struct-ref root 1))))]))