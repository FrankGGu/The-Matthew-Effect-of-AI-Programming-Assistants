(define (min-score n roads)
  (let* ([parent (make-vector (add1 n) 0)]
         [min-dist (make-vector (add1 n) +inf.0)]
         [find (lambda (u)
                 (if (= (vector-ref parent u) u)
                     u
                     (let ([p (find (vector-ref parent u))])
                       (vector-set! parent u p)
                       p)))]
         [union (lambda (u v d)
                  (let ([pu (find u)]
                        [pv (find v)])
                    (if (= pu pv)
                        (vector-set! min-dist pu (min (vector-ref min-dist pu) d))
                        (begin
                          (vector-set! parent pv pu)
                          (vector-set! min-dist pu (min (vector-ref min-dist pu) (vector-ref min-dist pv) d))))))])
    (for ([i (in-range (add1 n))])
      (vector-set! parent i i))
    (for ([road (in-list roads)])
      (let ([u (car road)]
            [v (cadr road)]
            [d (caddr road)])
        (union u v d)))
    (let ([root (find 1)])
      (if (= root (find n))
          (vector-ref min-dist root)
          -1))))