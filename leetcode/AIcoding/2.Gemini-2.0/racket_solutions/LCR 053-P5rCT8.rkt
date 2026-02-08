(define (inorder-successor root p)
  (let loop ([node root] [successor #f])
    (cond
      [(not node) successor]
      [(> (struct-ref node 0) (struct-ref p 0))
       (loop (struct-ref node 1) node)]
      [else
       (loop (struct-ref node 2) successor)])))