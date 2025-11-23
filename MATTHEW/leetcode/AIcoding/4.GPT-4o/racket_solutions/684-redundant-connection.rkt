(define (findRedundantDirectedConnection edges)
  (define parent (make-vector (add1 (length edges)) -1))
  (define (find x)
    (if (= (vector-ref parent x) -1)
        x
        (let ([root (find (vector-ref parent x))])
          (vector-set! parent x root)
          root)))

  (define (union x y)
    (let ([rootX (find x)]
          [rootY (find y)])
      (if (not (= rootX rootY))
          (vector-set! parent rootX rootY)))

  (define cycle (lambda (edges)
    (for ([edge edges])
      (let ([u (sub1 (car edge))]
            [v (sub1 (cadr edge))])
        (if (= (find u) (find v))
            (values #t edge)
            (union u v)))))

  (define result (cycle edges))
  (if (not (eq? result #f))
      (vector->list (cdr result))
      (let loop ((i (sub1 (length edges))))
        (if (< i 0)
            '()
            (let ([edge (list (sub1 (car (list-ref edges i)))
                              (sub1 (cadr (list-ref edges i))))])
              (if (not (eq? (cycle (list (list-ref edges i))) #f))
                  (loop (sub1 i))
                  edge)))))))