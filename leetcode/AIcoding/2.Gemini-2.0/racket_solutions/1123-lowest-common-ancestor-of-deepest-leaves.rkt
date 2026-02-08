(define (lowest-common-ancestor-deepest-leaves root)
  (define (depth node)
    (if (null? node)
        0
        (+ 1 (max (depth (car node)) (depth (cdr node))))))

  (define (lca node)
    (if (null? node)
        (values null 0)
        (let* ([ld (depth (car node))]
               [rd (depth (cdr node))]
               [(l ldep) (lca (car node))]
               [(r rdep) (lca (cdr node))])
          (cond
            [(= ld rd) (values node (+ 1 ld))]
            [(> ld rd) (values l (+ 1 ldep))]
            [else (values r (+ 1 rdep))]))))

  (car (lca root)))