(define (countComponents n edges)
  (define graph (make-vector n '()))
  (for-each (lambda (edge)
              (let ([u (car edge)]
                    [v (cadr edge)])
                (vector-set! graph (sub1 u) (cons (sub1 v) (vector-ref graph (sub1 u))))
                (vector-set! graph (sub1 v) (cons (sub1 u) (vector-ref graph (sub1 v))))))
            edges)

  (define visited (make-vector n #f))

  (define (dfs node)
    (vector-set! visited node #t)
    (for-each (lambda (neighbor)
                (unless (vector-ref visited neighbor)
                  (dfs neighbor)))
              (vector-ref graph node)))

  (define count 0)
  (for-each (lambda (i)
              (when (not (vector-ref visited i))
                (dfs i)
                (set! count (+ count 1))))
            (range n))
  count)

(define (countConnectedComponents n edges)
  (countComponents n edges))