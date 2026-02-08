(define (distance-k root target k)
  (define (build-graph node parent graph)
    (cond
      [(null? node) graph]
      [else
       (let ([new-graph (dict-set graph (car node) (list))]
             [new-graph (if (not (null? parent))
                            (dict-update new-graph (car node) (lambda (v) (append v (list (car parent)))) (list (car parent)))
                            new-graph)]
             [new-graph (if (not (null? parent))
                            (dict-update new-graph (car parent) (lambda (v) (append v (list (car node)))) (list (car node)))
                            new-graph)])
         (define left (cadr node))
         (define right (caddr node))
         (let* ([new-graph (if (not (null? left))
                              (build-graph left node new-graph)
                              new-graph)]
                [new-graph (if (not (null? right))
                              (build-graph right node new-graph)
                              new-graph)])
           new-graph))]))

  (define graph (build-graph root null (dict)))

  (define (bfs start k graph)
    (define visited (make-hash))
    (hash-set! visited start #t)
    (define queue (list (list start 0)))
    (define result '())

    (let loop ([queue queue])
      (cond
        [(null? queue) result]
        [else
         (let* ([current (car (car queue))]
                [distance (cadr (car queue))])
           (cond
             [(= distance k) (set! result (append result (list current)))]
             [(< distance k)
              (let ([neighbors (dict-ref graph current #f)])
                (let next-neighbors-loop ([neighbors neighbors])
                  (cond
                    [(null? neighbors) (void)]
                    [else
                     (let ([neighbor (car neighbors)])
                       (if (not (hash-ref visited neighbor #f))
                           (begin
                             (hash-set! visited neighbor #t)
                             (set! queue (append (cdr queue) (list (list neighbor (+ distance 1)))))
                             ))
                       (next-neighbors-loop (cdr neighbors))))])))]))
         (loop (cdr queue))])))

  (bfs (car target) k graph))