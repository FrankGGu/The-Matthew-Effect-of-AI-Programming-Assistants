(define (valid-arrangement pairs)
  (define (build-graph pairs)
    (define graph (make-hash))
    (for-each (lambda (p)
                (let ((u (car p)) (v (cdr p)))
                  (hash-update! graph u (lambda (x) (cons v x)) '())
                  (hash-update! graph v (lambda (x) x) '())))
              pairs)
    graph)

  (define (build-degree-graph pairs)
    (define in-degree (make-hash))
    (define out-degree (make-hash))
    (for-each (lambda (p)
                (let ((u (car p)) (v (cdr p)))
                  (hash-update! out-degree u (lambda (x) (+ x 1)) 0)
                  (hash-update! in-degree v (lambda (x) (+ x 1)) 0)
                  (hash-update! in-degree u (lambda (x) x) 0)
                  (hash-update! out-degree v (lambda (x) x) 0)))
              pairs)
    (values in-degree out-degree))

  (define (find-start-node in-degree out-degree)
    (define nodes (set))
    (hash-for-each in-degree (lambda (k v) (set-add! nodes k)))
    (hash-for-each out-degree (lambda (k v) (set-add! nodes k)))

    (for ([node (in-set nodes)])
      (let ((in-deg (hash-ref in-degree node 0))
            (out-deg (hash-ref out-degree node 0)))
        (when (> out-deg in-deg)
          (return node))))

    (car (hash-keys (build-graph pairs))))

  (define (eulerian-path graph start-node)
    (define path '())
    (define (dfs node)
      (let loop ((neighbors (hash-ref graph node '())))
        (cond
          [(null? neighbors)
           (set! path (cons node path))]
          [else
           (let ((neighbor (car neighbors)))
             (hash-update! graph node (lambda (x) (filter (lambda (y) (not (equal? y neighbor))) x)) '())
             (dfs neighbor)
             (set! path (cons node path)))])))
    (dfs start-node)
    path)

  (define (convert-to-pairs path)
    (cond
      [(null? path) '()]
      [(null? (cdr path)) '()]
      [else (cons (list (car path) (cadr path)) (convert-to-pairs (cdr path)))]))

  (let-values ([(in-degree out-degree) (build-degree-graph pairs)])
    (let ((graph (build-graph pairs))
          (start-node (find-start-node in-degree out-degree)))
      (let ((path (eulerian-path graph start-node)))
        (reverse (convert-to-pairs path))))))