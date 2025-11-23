(define (coin-change coins amount)
  (define dp (make-vector (+ amount 1) (+ amount 1)))
  (vector-set! dp 0 0)
  (for ([i (in-range 1 (+ amount 1))])
    (vector-set! dp i (+ amount 1)))

  (for ([coin (in-list coins)])
    (for ([i (in-range coin (+ amount 1))])
      (vector-set! dp i (min (vector-ref dp i) (+ (vector-ref dp (- i coin)) 1)))))

  (let ([result (vector-ref dp amount)])
    (if (= result (+ amount 1))
        -1
        result)))