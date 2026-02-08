(define (solution n queries)
  (define parents (make-vector (+ n 1) 0))
  (define ranks (make-vector (+ n 1) 0))

  (for ([i (in-range 1 (+ n 1))])
    (vector-set! parents i i)
    (vector-set! ranks i 0))

  (define (find x)
    (if (= (vector-ref parents x) x)
        x
        (let ([root (find (vector-ref parents x))])
          (vector-set! parents x root)
          root)))

  (define (union x y)
    (let ([root-x (find x)]
          [root-y (find y)])
      (unless (= root-x root-y)
        (let ([rank-x (vector-ref ranks root-x)]
              [rank-y (vector-ref ranks root-y)])
          (cond
            [(> rank-x rank-y) (vector-set! parents root-y root-x)]
            [(< rank-x rank-y) (vector-set! parents root-x root-y)]
            [else
             (vector-set! parents root-y root-x)
             (vector-set! ranks root-x (+ rank-x 1))])))))

  (define results '())
  (for ([query queries])
    (match query
      [(list "addEdge" u v)
       (union u v)]
      [(list "query" u v)
       (set! results (cons (= (find u) (find v)) results))]
      [_ (error "Invalid query type")]))

  (reverse results))