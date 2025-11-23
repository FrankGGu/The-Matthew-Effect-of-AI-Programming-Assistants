(define (merge-trees t1 t2)
  (cond
    [(null? t1) t2]
    [(null? t2) t1]
    [else (let ([new-node (make-node (+ (node-val t1) (node-val t2)))])
            (set-left! new-node (merge-trees (left t1) (left t2)))
            (set-right! new-node (merge-trees (right t1) (right t2)))
            new-node)]))