(define (pruneTree root)
  (cond
    [(null? root) null]
    [else
     (let* ([left-pruned (pruneTree (car root))]
            [right-pruned (pruneTree (cadr root))]
            [new-root (list left-pruned right-pruned (caddr root))])
       (if (and (null? left-pruned) (null? right-pruned) (= (caddr root) 0))
           null
           new-root))]))