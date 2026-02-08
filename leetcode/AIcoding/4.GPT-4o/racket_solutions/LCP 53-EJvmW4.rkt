(define (guard-space-city n roads)
  (define graph (make-vector n '()))
  (for ([road roads])
    (let ([u (car road)] 
          [v (cadr road)])
      (vector-set! graph u (cons v (vector-ref graph u)))
      (vector-set! graph v (cons u (vector-ref graph v)))))

  (define (dfs node visited)
    (set! visited (cons node visited))
    (for ([neighbor (vector-ref graph node)])
      (unless (member neighbor visited)
        (dfs neighbor visited))))

  (define visited '())
  (for ([i (in-range n)])
    (unless (member i visited)
      (dfs i visited)))

  (length visited))

(guard-space-city 5 '((0 1) (1 2) (2 0) (1 3) (3 4)))