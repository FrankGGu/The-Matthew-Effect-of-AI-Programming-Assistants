(define/contract (distribute-coins root)
  (-> (or/c null? tree-node?) exact-integer?)
  (define moves 0)
  (define (dfs node)
    (if (null? node)
        0
        (let* ([left (dfs (tree-node-left node))]
               [right (dfs (tree-node-right node))]
               [coins (- (+ (tree-node-val node) left right) 1)])
          (set! moves (+ moves (abs left) (abs right)))
          coins)))
  (dfs root)
  moves)

(define-struct tree-node [val left right] #:transparent #:mutable)