(define (evaluate-tree root)
  (cond
    [(null? root) #f]
    [(= (node-val root) 0) #f]
    [(= (node-val root) 1) #t]
    [(= (node-val root) 2) (or (evaluate-tree (node-left root)) (evaluate-tree (node-right root)))]
    [(= (node-val root) 3) (and (evaluate-tree (node-left root)) (evaluate-tree (node-right root)))]
    [else #f]))