(define (level-order root)
  (if (null? root)
      '()
      (let loop ([queue (list root)] [result '()])
        (if (null? queue)
            result
            (let* ([level-nodes '()]
                   [next-queue '()]
                   [process-level
                    (lambda (q)
                      (cond
                        [(null? q) (values level-nodes next-queue)]
                        [else
                         (let ([node (car q)])
                           (values
                            (append level-nodes (list (node-val node)))
                            (append next-queue (node-children node)))
                           (apply process-level (cdr q)))]))])
              (let-values ([(level-nodes next-queue)] (process-level queue))
                (loop next-queue (append result (list level-nodes)))))))))

(struct node (val children) #:transparent)