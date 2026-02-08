(define (largest-local matrix)
  (define n (vector-length matrix))
  (define result (make-vector (- n 2) (make-vector (- n 2) 0)))

  (for ([i (in-range 1 (- n 1))])
    (for ([j (in-range 1 (- n 1))])
      (define max-val
        (for/fold ([max-v -inf.0]
                   #:result max-v)
                  ([x (in-range (- i 1) (+ i 2))])
                  (for/fold ([max-v2 -inf.0]
                               #:result max-v2)
                              ([y (in-range (- j 1) (+ j 2))])
                              (max max-v2 (vector-ref (vector-ref matrix x) y)))))
      (vector-set! (vector-ref result (- i 1)) (- j 1) max-val)))

  result)