(define/contract (good-nodes root)
  (-> (or/c null? (tree-node/c exact-integer?)) exact-integer?)
  (define (helper node max-so-far)
    (if (null? node)
        0
        (let* ([current-val (tree-node-val node)]
               [new-max (max max-so-far current-val)]
               [count (if (>= current-val max-so-far) 1 0)])
          (+ count
             (helper (tree-node-left node) new-max)
             (helper (tree-node-right node) new-max)))))
  (helper root (tree-node-val root)))
)