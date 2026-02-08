(define/contract (rob root)
  (-> (or/c null? (tree-node/c exact-integer?)) exact-integer?)
  (define (helper node)
    (if (null? node)
        (list 0 0)
        (let* ([left (helper (tree-node-left node))]
               [right (helper (tree-node-right node))]
               [rob-this (+ (tree-node-val node) (second left) (second right))]
               [not-rob-this (+ (max (first left) (second left)) (max (first right) (second right)))])
          (list rob-this not-rob-this))))
  (let ([res (helper root)])
    (max (first res) (second res))))