(define (count-restricted-paths n edges)
  (define graph (make-hash))
  (for-each (lambda (edge)
              (let ((u (car edge))
                    (v (cadr edge))
                    (w (caddr edge)))
                (hash-update! graph u (lambda (l) (cons (cons v w) l)) '())
                (hash-update! graph v (lambda (l) (cons (cons u w) l)) '())))
            edges)

  (define dist (make-vector (+ n 1) #f))
  (vector-set! dist n 0)

  (define pq (make-priority-queue #:priority (lambda (x) (vector-ref dist x))
                                  #:less-than? <))

  (priority-queue-add! pq n)

  (define (dijkstra)
    (while (not (priority-queue-empty? pq))
      (let ((u (priority-queue-remove! pq)))
        (when (hash-has-key? graph u)
          (for-each (lambda (neighbor)
                      (let ((v (car neighbor))
                            (w (cdr neighbor)))
                        (when (or (not (vector-ref dist v))
                                  (> (+ (vector-ref dist u) w) (vector-ref dist v)))
                          (vector-set! dist v (+ (vector-ref dist u) w))
                          (priority-queue-add! pq v))))
                    (hash-ref graph u '()))))))

  (dijkstra)

  (define dp (make-vector (+ n 1) 0))
  (vector-set! dp n 1)

  (define (dfs u)
    (cond [(> (vector-ref dp u) 0) (vector-ref dp u)]
          [(not (hash-has-key? graph u)) 0]
          [else 
           (let ((count 0))
             (for-each (lambda (neighbor)
                         (let ((v (car neighbor)))
                           (when (> (vector-ref dist u) (vector-ref dist v))
                             (set! count (modulo (+ count (dfs v)) 1000000007)))))
                       (hash-ref graph u '()))
             (vector-set! dp u count)
             count)]))

  (dfs 1))