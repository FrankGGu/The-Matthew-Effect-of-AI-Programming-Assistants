(define/contract (largest-values root)
  (-> (or/c null? tree-node?) (listof exact-integer?))
  (if (null? root)
      '()
      (let loop ([nodes (list root)]
                 [result '()])
        (if (null? nodes)
            (reverse result)
            (let* ([vals (map (lambda (n) (tree-node-val n)) nodes)]
                   [max-val (apply max vals)]
                   [children (append* (map (lambda (n) 
                                           (append 
                                            (if (null? (tree-node-left n)) '() (list (tree-node-left n)))
                                            (if (null? (tree-node-right n)) '() (list (tree-node-right n))))) 
                                     nodes)])
              (loop children (cons max-val result))))))