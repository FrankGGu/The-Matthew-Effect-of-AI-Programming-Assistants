(define/contract (connect root)
  (-> (or/c #f node?) (or/c #f node?))
  (if (not root)
      root
      (let loop ([node root])
        (let ([dummy (make-node 0 #f #f #f)]
              [tail dummy])
          (let connect-level ([curr node])
            (when curr
              (when (node-left curr)
                (set-node-next! tail (node-left curr))
                (set! tail (node-next tail)))
              (when (node-right curr)
                (set-node-next! tail (node-right curr))
                (set! tail (node-next tail)))
              (connect-level (node-next curr))))
          (when (node-next dummy)
            (loop (node-next dummy)))))
      root))