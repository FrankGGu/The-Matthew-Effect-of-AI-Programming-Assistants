(define (find-redundant-connection edges)
  (let* ([n (length edges)]
         [parent (make-vector (+ n 1) 0)])
    (define (find u)
      (if (zero? (vector-ref parent u))
          u
          (let ([p (find (vector-ref parent u))])
            (vector-set! parent u p)
            p)))
    (define (union u v)
      (let ([pu (find u)]
            [pv (find v)])
        (if (= pu pv)
            #f
            (begin
              (vector-set! parent pv pu)
              #t))))
    (for/or ([edge edges])
      (let ([u (car edge)]
            [v (cadr edge)])
        (if (not (union u v))
            edge
            #f)))))