(define (maximum-sum root)
  (define (dfs node)
    (cond
      [(null? node) (cons 0 0)]
      [else
       (let* ([left (dfs (vector-ref node 1))]
              [right (dfs (vector-ref node 2))]
              [include-node (+ (vector-ref node 0) (cdr left) (cdr right))]
              [exclude-node (max (+ (car left) (car right))
                                  (+ (car left) (cdr right))
                                  (+ (cdr left) (car right))
                                  (+ (cdr left) (cdr right)))])
         (cons include-node exclude-node))]))
  (apply max (dfs root)))