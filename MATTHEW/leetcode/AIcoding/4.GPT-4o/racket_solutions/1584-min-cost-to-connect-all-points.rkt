(define (min-cost-connect-points points)
  (define (distance p1 p2)
    (+ (abs (- (car p1) (car p2))) (abs (- (cadr p1) (cadr p2)))))

  (define n (length points))
  (define edges (for/list ([i (in-range n)] )
                  (for/list ([j (in-range n)] [#:when (not (= i j))])
                    (list (distance (list-ref points i) (list-ref points j)) i j))))

  (define (find parent x)
    (if (not (= (vector-ref parent x) x))
        (set! (vector-ref parent x) (find parent (vector-ref parent x)))
        x))

  (define (union parent rank x y)
    (define rootX (find parent x))
    (define rootY (find parent y))
    (if (not (= rootX rootY))
        (begin
          (if (> (vector-ref rank rootX) (vector-ref rank rootY))
              (set! (vector-ref parent rootY) rootX)
              (begin
                (set! (vector-ref parent rootX) rootY)
                (when (= (vector-ref rank rootX) (vector-ref rank rootY))
                  (set! (vector-ref rank rootY) (+ (vector-ref rank rootY) 1))))))))

  (define (kruskal)
    (define parent (make-vector n))
    (define rank (make-vector n 0))
    (for ([i (in-range n)]) (vector-set! parent i i))
    (define mst-cost 0)
    (for ([edge (sort edges (lambda (e1 e2) (< (car e1) (car e2))))])
      (define cost (car edge))
      (define u (cadr edge))
      (define v (caddr edge))
      (if (not (= (find parent u) (find parent v)))
          (begin
            (union parent rank u v)
            (set! mst-cost (+ mst-cost cost)))))
    mst-cost)

  (kruskal))