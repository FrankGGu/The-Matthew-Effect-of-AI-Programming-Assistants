(define/contract (increasing-bst root)
  (-> (or/c null? tree-node?) (or/c null? tree-node?))
  (define (in-order node lst)
    (if (null? node)
        lst
        (let* ([left (tree-node-left node)]
               [right (tree-node-right node)]
               [val (tree-node-val node)]
               [lst (in-order left lst)])
          (set! lst (append lst (list val)))
          (in-order right lst)))
  (define lst (in-order root '()))
  (if (null? lst)
      null
      (let loop ([nodes lst] [result null])
        (if (null? nodes)
            result
            (let ([new-node (make-tree-node (car nodes) null null)])
              (if (null? result)
                  (loop (cdr nodes) new-node)
                  (begin
                    (set-tree-node-right! result new-node)
                    (loop (cdr nodes) new-node)))))))