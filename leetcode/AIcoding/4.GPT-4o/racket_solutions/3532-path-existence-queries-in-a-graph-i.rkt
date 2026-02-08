(define (valid-path n edges start end)
  (define graph (make-vector n '()))
  (for-each (lambda (edge)
              (let ((u (car edge))
                    (v (cadr edge)))
                (vector-set! graph u (cons v (vector-ref graph u)))
                (vector-set! graph v (cons u (vector-ref graph v)))))
            edges)

  (define visited (make-vector n #f))

  (define (dfs node)
    (if (equal? node end)
        #t
        (begin
          (vector-set! visited node #t)
          (for/or ([neighbor (vector-ref graph node)])
            (and (not (vector-ref visited neighbor))
                 (dfs neighbor))))))

  (dfs start))