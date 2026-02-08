(define (pruneTree root)
  (cond
    [(null? root) null]
    [else
     (let* ([left (pruneTree (left root))]
            [right (pruneTree (right root))])
       (set-struct-field! root 1 left)
       (set-struct-field! root 2 right)
       (if (and (zero? (val root)) (null? left) (null? right))
           null
           root))]))