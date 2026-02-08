(define (calc-equation equations values queries)
  (define graph (make-hash))
  (for/list ([i (in-range (length equations))])
    (let* ([eq (list-ref equations i)]
           [a (list-ref eq 0)]
           [b (list-ref eq 1)]
           [v (list-ref values i)])
      (hash-update! graph a (lambda (x) (cons (cons b v) x)) '())
      (hash-update! graph b (lambda (x) (cons (cons a (/ 1.0 v)) x)) '())))

  (define (dfs start end visited)
    (cond
      [(equal? start end) 1.0]
      [(not (hash-has-key? graph start)) -1.0]
      [else
       (let ([neighbors (hash-ref graph start)])
         (for/first ([neighbor (in-list neighbors)]
                     #:when (not (member (car neighbor) visited))
                     #:let ([next-node (car neighbor)]
                           [weight (cdr neighbor)])
                     #:when (not (equal? (dfs next-node end (cons start visited)) -1.0))
                     (let ([result (dfs next-node end (cons start visited))])
                       (* weight result)))
         -1.0))]))

  (for/list ([query (in-list queries)])
    (let ([start (list-ref query 0)]
          [end (list-ref query 1)])
      (dfs start end '()))))