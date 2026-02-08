(define (min-cost-to-split arr cost)
  (define n (length arr))
  (define dp (make-vector (+ n 1) (make-vector (+ n 1) (expt 10 9))))
  (vector-set! dp 0 0)

  (define (min a b) (if (< a b) a b))

  (for ([i (in-range 1 (+ n 1))])
    (for ([j (in-range i)])
      (define sum (apply + (sublist arr j (sub1 i))))
      (define total-cost (+ (vector-ref dp j) (* sum cost)))
      (vector-set! dp i (min (vector-ref dp i) total-cost))))

  (vector-ref dp n))

(define (minCost arr cost)
  (min-cost-to-split arr cost))