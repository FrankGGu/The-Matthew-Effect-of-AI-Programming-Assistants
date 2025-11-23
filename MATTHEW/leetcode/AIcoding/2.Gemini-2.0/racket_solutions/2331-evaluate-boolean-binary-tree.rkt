(define (evaluate-tree root)
  (cond
    [(null? root) #f]
    [(= (vector-ref root 0) 0) #f]
    [(= (vector-ref root 0) 1) #t]
    [(= (vector-ref root 0) 2) (or (evaluate-tree (vector-ref root 1)) (evaluate-tree (vector-ref root 2)))]
    [(= (vector-ref root 0) 3) (and (evaluate-tree (vector-ref root 1)) (evaluate-tree (vector-ref root 2)))]
    [else #f]))