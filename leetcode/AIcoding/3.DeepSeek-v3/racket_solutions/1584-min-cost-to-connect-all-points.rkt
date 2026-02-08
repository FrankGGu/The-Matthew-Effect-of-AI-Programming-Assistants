(define (min-cost-connect-points points)
  (define n (length points))
  (if (<= n 1) 0
      (let* ([edges (for*/list ([i (in-range n)]
                                [j (in-range (add1 i) n)])
                      (let ([x1 (list-ref (list-ref points i) 0)]
                            [y1 (list-ref (list-ref points i) 1)]
                            [x2 (list-ref (list-ref points j) 0)]
                            [y2 (list-ref (list-ref points j) 1)])
                        (list (abs (- x1 x2)) (abs (- y1 y2)) i j)))]
             [sorted-edges (sort edges (lambda (a b) (< (+ (car a) (cadr a)) (+ (car b) (cadr b)))))])
        (let ([parent (make-vector n 0)])
          (for ([i (in-range n)]) (vector-set! parent i i))
          (define (find u)
            (if (= (vector-ref parent u) u) u
                (begin (vector-set! parent u (find (vector-ref parent u)))
                       (vector-ref parent u))))
          (define (union u v)
            (let ([pu (find u)]
                  [pv (find v)])
              (vector-set! parent pu pv)))
          (let loop ([edges sorted-edges]
                     [count 0]
                     [res 0])
            (if (>= count (- n 1)) res
                (let* ([e (car edges)]
                       [cost (+ (car e) (cadr e))]
                       [u (caddr e)]
                       [v (cadddr e)])
                  (if (not (= (find u) (find v)))
                      (begin (union u v)
                             (loop (cdr edges) (add1 count) (+ res cost)))
                      (loop (cdr edges) count res)))))))))