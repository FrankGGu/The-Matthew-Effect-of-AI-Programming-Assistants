(define (countCompleteComponents n edges)
  (define graph (make-vector n '()))
  (for-each (lambda (edge)
              (let ((u (car edge))
                    (v (cadr edge)))
                (vector-set! graph u (cons v (vector-ref graph u)))
                (vector-set! graph v (cons u (vector-ref graph v)))))
            edges)

  (define visited (make-vector n #f))

  (define (dfs node)
    (set! visited node #t)
    (for-each (lambda (neighbor)
                (unless (vector-ref visited neighbor)
                  (dfs neighbor)))
              (vector-ref graph node)))

  (define (isCompleteComponent start)
    (let loop ((count 0) (edges-count 0))
      (if (vector-ref visited start)
          (if (= count edges-count) 
              #t 
              #f)
          (begin
            (set! visited start #t)
            (for-each (lambda (neighbor)
                        (loop (+ count 1) 
                              (+ edges-count (length (vector-ref graph neighbor)))))
                      (vector-ref graph start))
            (loop (+ count 1) edges-count)))))

  (define complete-count 0)
  (for ((i (in-range n)))
    (when (not (vector-ref visited i))
      (if (isCompleteComponent i)
          (set! complete-count (+ complete-count 1)))))

  complete-count)