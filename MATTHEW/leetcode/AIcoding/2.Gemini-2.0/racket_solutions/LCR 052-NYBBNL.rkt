(define (increasing-BST root)
  (let loop ([node root] [tail '()])
    (cond
      [(null? node) tail]
      [else (loop (node-left node)
                  (cons (make-node (node-val node) null null)
                        (loop (node-right node) tail)))])))