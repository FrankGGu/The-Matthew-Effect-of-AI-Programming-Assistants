(define/contract (minimum-cost logs n connections)
  (-> exact-integer? (listof (listof exact-integer?)) exact-integer?)
  (define parent (make-vector n 0))
  (for ([i (in-range n)])
    (vector-set! parent i i))

  (define (find u)
    (if (= (vector-ref parent u) u)
        u
        (begin
          (vector-set! parent u (find (vector-ref parent u)))
          (vector-ref parent u))))

  (define (union u v)
    (let ([pu (find u)]
          [pv (find v)])
      (when (not (= pu pv))
        (vector-set! parent pv pu))))

  (define sorted-conns (sort connections (lambda (a b) (< (third a) (third b)))))
  (define total-cost 0)
  (define components n)

  (for ([conn sorted-conns] #:break (<= components 1))
    (define u (first conn))
    (define v (second conn))
    (define cost (third conn))
    (when (not (= (find u) (find v)))
      (union u v)
      (set! total-cost (+ total-cost cost))
      (set! components (- components 1))))

  (if (= components 1) total-cost -1))