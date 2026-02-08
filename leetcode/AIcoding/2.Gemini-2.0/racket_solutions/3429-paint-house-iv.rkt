(define (min-cost-ii costs target)
  (define n (vector-length costs))
  (define k (vector-length (vector-ref costs 0)))

  (define dp (make-vector (add1 n) (make-vector (add1 target) #f)))

  (for ([i (in-range (add1 n))])
    (vector-set! (vector-ref dp i) 0 #f))

  (for ([j (in-range (add1 target))])
    (vector-set! (vector-ref dp 0) j #f))

  (vector-set! (vector-ref dp 0) 0 0)

  (for ([i (in-range 1 (add1 n))])
    (for ([j (in-range 1 (add1 target))])
      (define min-cost #f)
      (for ([l (in-range k)])
        (let ([cost (vector-ref (vector-ref costs (sub1 i)) l)])
          (if (>= j cost)
              (let ([prev-cost (vector-ref (vector-ref dp (sub1 i)) (- j cost))])
                (if prev-cost
                    (if min-cost
                        (set! min-cost (min min-cost (+ prev-cost cost)))
                        (set! min-cost (+ prev-cost cost)))))
              #f)))
      (vector-set! (vector-ref dp i) j min-cost)))

  (vector-ref (vector-ref dp n) target))