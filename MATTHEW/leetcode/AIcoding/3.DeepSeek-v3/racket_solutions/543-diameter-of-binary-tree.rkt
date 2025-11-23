(define/contract (diameter-of-binary-tree root)
  (-> (or/c null? tree-node?) exact-nonnegative-integer?)
  (define max-diameter 0)
  (define (height node)
    (if (null? node)
        0
        (let ([left-height (height (tree-node-left node))]
              [right-height (height (tree-node-right node))])
          (set! max-diameter (max max-diameter (+ left-height right-height)))
          (+ 1 (max left-height right-height)))))
  (height root)
  max-diameter)