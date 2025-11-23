(define/contract (good-nodes root)
  (-> (or/c null? tree-node?) exact-integer?)
  (define (helper node max-val)
    (if (null? node)
        0
        (let* ([current-val (tree-node-val node)]
               [new-max (max max-val current-val)]
               [count (if (>= current-val max-val) 1 0)])
          (+ count
             (helper (tree-node-left node) new-max)
             (helper (tree-node-right node) new-max)))))
  (if (null? root)
      0
      (helper root (tree-node-val root))))