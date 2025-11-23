(define/contract (connect root)
  (-> (or/c #f node?) (or/c #f node?))
  (if (not root)
      root
      (let loop ([node root])
        (when node
          (let ([left (node-left node)]
                [right (node-right node)])
            (when left
              (set-node-next! left right)
              (let ([next (node-next node)])
                (when next
                  (set-node-next! right (node-next-left next)))))
            (loop left)
            (loop right))))
      root))