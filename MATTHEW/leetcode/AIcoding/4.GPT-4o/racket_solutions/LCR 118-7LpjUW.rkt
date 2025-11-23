(define (find-redundant-directed-connection edges)
  (define (find-parent parent node)
    (if (equal? (vector-ref parent node) node)
        node
        (let ([p (find-parent parent (vector-ref parent node))])
          (vector-set! parent node p)
          p)))

  (define (union parent rank u v)
    (let* ([pu (find-parent parent u)]
           [pv (find-parent parent v)])
      (cond
        [(equal? pu pv) #f]
        [(< (vector-ref rank pu) (vector-ref rank pv))
         (vector-set! parent pu pv)]
        [(> (vector-ref rank pu) (vector-ref rank pv))
         (vector-set! parent pv pu)]
        [else
         (vector-set! parent pu pv)
         (vector-set! rank pv (+ (vector-ref rank pv) 1))])))

  (define n (length edges))
  (define parent (make-vector (add1 n)))
  (define rank (make-vector (add1 n) 0))
  (for ([i (in-range (add1 n))])
    (vector-set! parent i i))

  (define last-edge #f)
  (for ([edge edges])
    (define u (car edge))
    (define v (cadr edge))
    (if (equal? (union parent rank u v) #f)
        (set! last-edge edge)))

  (if last-edge
      last-edge
      (vector->list (for/fold ([visited (make-vector (add1 n) #f)]) ([edge edges] visited)
                     (let ([u (car edge)]
                           [v (cadr edge)])
                       (union parent rank u v)
                       visited)))))