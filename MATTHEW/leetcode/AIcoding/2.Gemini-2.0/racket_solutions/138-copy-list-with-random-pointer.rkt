(define (copy-random-list head)
  (define hash (make-hash))
  (define (copy-node node)
    (cond
      [(null? node) null]
      [(hash-ref hash node #f) (hash-ref hash node)]
      [else
       (let ([new-node (list (list-ref node 0) null)])
         (hash-set! hash node new-node)
         (list-set! new-node 1 (copy-node (list-ref node 1)))
         new-node)]))

  (define (copy-random node)
    (cond
      [(null? node) null]
      [else
       (let ([new-node (hash-ref hash node)])
         (list-set! new-node 1 (if (null? (list-ref node 2))
                                   null
                                   (hash-ref hash (list-ref node 2))))
         new-node)]))

  (when (not (null? head))
    (let ([new-head (copy-node head)])
      (let loop ([node head])
        (when (not (null? node))
          (copy-random node)
          (loop (list-ref node 1))))
      (hash-ref hash head))))