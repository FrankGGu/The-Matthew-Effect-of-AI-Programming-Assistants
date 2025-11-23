(define (count-valid-paths n edges)
  (define graph (make-vector n '()))
  (for ([edge edges])
    (let ([u (car edge)]
          [v (cadr edge)])
      (vector-set! graph u (cons v (vector-ref graph u)))
      (vector-set! graph v (cons u (vector-ref graph v)))))

  (define (dfs node parent path)
    (if (null? path)
      1
      (let ([total 0])
        (for ([neighbor (vector-ref graph node)])
          (when (not (= neighbor parent))
            (set! total (+ total (dfs neighbor node (cdr path))))))
        total)))

  (dfs 0 -1 (list 1))
)