(define (timeToMarkAllNodes n edges time)
  (define graph (make-vector n '()))
  (for-each (lambda (edge)
              (let ((u (car edge))
                    (v (cadr edge)))
                (vector-set! graph u (cons v (vector-ref graph u)))
                (vector-set! graph v (cons u (vector-ref graph v)))))
            edges)

  (define (dfs node visited)
    (if (vector-ref visited node)
        0
        (begin
          (vector-set! visited node #t)
          (apply + (cons time (map (lambda (neighbor)
                                      (dfs neighbor visited))
                                    (vector-ref graph node)))))))

  (define visited (make-vector n #f))
  (dfs 0 visited))

(timeToMarkAllNodes n edges time)