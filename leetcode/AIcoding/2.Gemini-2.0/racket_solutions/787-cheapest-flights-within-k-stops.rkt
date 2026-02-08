(define (find-cheapest-price n flights src dst k)
  (define dp (make-vector (+ k 2) (make-vector n +inf.0)))
  (vector-set! (vector-ref dp 0) src 0)
  (for ([i (in-range 1 (+ k 2))])
    (let ([dp-prev (vector-ref dp (- i 1))]
          [dp-curr (vector-ref dp i)])
      (vector-copy! dp-curr 0 dp-prev 0 n)
      (for ([flight flights])
        (let ([u (car flight)]
              [v (cadr flight)]
              [price (caddr flight)])
          (set! (vector-ref dp-curr v) (min (vector-ref dp-curr v) (+ (vector-ref dp-prev u) price)))))))
  (let ([result (vector-ref dp (+ k 1) dst)])
    (if (= result +inf.0) -1 result)))