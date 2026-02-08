(define (copy-random-list head)
  (if (null? head)
      null
      (let ([node-map (make-hash)])
        (letrec ([copy-node (lambda (node)
                               (cond
                                 [(null? node) null]
                                 [(hash-has-key? node-map node) (hash-ref node-map node)]
                                 [else
                                  (let ([new-node (list 'val (car node) 'next null 'random null)])
                                    (hash-set! node-map node new-node)
                                    new-node)]))])
          (letrec ([populate-node (lambda (node new-node)
                                     (cond
                                       [(null? node) null]
                                       [else
                                        (let ([next-node (cdr node)]
                                              [random-node (if (null? (cddr node)) null (caddr node))])
                                          (datum->syntax #f (set-car! (cdr new-node) (copy-node next-node)))
                                          (datum->syntax #f (set-car! (cdddr new-node) (copy-node random-node)))
                                          (populate-node next-node (cdr new-node))))]))
            (let ([new-head (copy-node head)])
              (populate-node head new-head)
              new-head)))))))