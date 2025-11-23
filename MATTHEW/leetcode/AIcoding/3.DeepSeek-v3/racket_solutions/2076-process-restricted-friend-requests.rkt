#lang racket

(define (friend-requests n restrictions requests)
  (define parent (make-vector n))
  (for ([i n]) (vector-set! parent i i))

  (define (find u)
    (if (= (vector-ref parent u) u)
        u
        (let ([p (find (vector-ref parent u))])
          (vector-set! parent u p)
          p)))

  (define (union u v)
    (let ([pu (find u)]
          [pv (find v)])
      (vector-set! parent pu pv)))

  (define result '())
  (for ([req requests])
    (let ([u (car req)]
          [v (cadr req)])
    (let ([pu (find u)]
          [pv (find v)])
      (define conflict #f)
      (for ([res restrictions])
        (let ([a (car res)]
              [b (cadr res)])
          (let ([pa (find a)]
                [pb (find b)])
            (when (or (and (= pu pa) (= pv pb))
                      (and (= pu pb) (= pv pa)))
              (set! conflict #t)))))
      (if conflict
          (set! result (cons #f result))
          (begin
            (union u v)
            (set! result (cons #t result))))))
  (reverse result))