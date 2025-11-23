(define (deepestLeavesSum root)
  (define (helper nodes)
    (if (null? nodes)
        0
        (let loop ((next-nodes '())
                   (sum 0))
          (if (null? nodes)
              (if (null? next-nodes)
                  sum
                  (loop next-nodes 0))
              (loop (append next-nodes
                            (map (lambda (node)
                                   (if (or (null? (node-left node))
                                           (null? (node-right node)))
                                       '()
                                       (list (node-left node) (node-right node))))
                                 nodes))
                    (+ sum (node-val (car nodes))))))))
  (helper (list root)))