(define (maximum-sum-of-edge-values n edges)
  (let* ([parent (make-vector n)]
         [rank (make-vector n 0)]
         [find (lambda (u)
                 (if (= (vector-ref parent u) u)
                     u
                     (let ([p (find (vector-ref parent u))])
                       (vector-set! parent u p)
                       p)))]
         [union (lambda (u v)
                  (let ([pu (find u)]
                        [pv (find v)])
                    (cond
                      [(= pu pv) #f]
                      [(< (vector-ref rank pu) (vector-ref rank pv))
                       (vector-set! parent pu pv)]
                      [else
                       (vector-set! parent pv pu)
                       (when (= (vector-ref rank pu) (vector-ref rank pv))
                       (vector-set! rank pu (+ (vector-ref rank pu) 1))])
                    #t))])
    (for ([i (in-range n)])
      (vector-set! parent i i))
    (let ([sorted-edges (sort edges (lambda (a b) (> (third a) (third b))))]
          [res 0])
      (for ([edge (in-list sorted-edges)])
        (let ([u (first edge)]
              [v (second edge)]
              [w (third edge)])
          (when (union u v)
            (set! res (+ res w))))
      res)))