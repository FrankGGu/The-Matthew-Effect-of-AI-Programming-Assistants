(define (countVisitedNodes n edges start)
  (define graph (make-vector n '()))
  (for ([edge edges])
    (let ([u (car edge)] [v (cadr edge)])
      (vector-set! graph u (cons v (vector-ref graph u)))))
  (define visited (make-vector n #f))

  (define (dfs node)
    (if (vector-ref visited node)
        0
        (begin
          (vector-set! visited node #t)
          (+ 1 (apply + (map dfs (vector-ref graph node)))))))

  (dfs start))