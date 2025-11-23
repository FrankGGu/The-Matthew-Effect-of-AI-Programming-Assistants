(define (maxPoints points)
  (define n (length points))
  (define m (length (car points)))
  (define dp (make-vector m 0))

  (for ([j (in-range m)])
    (vector-set! dp j (vector-ref (list-ref points 0) j)))

  (for ([i (in-range 1 n)])
    (define new-dp (make-vector m 0))
    (define max-left (make-vector m 0))
    (define max-right (make-vector m 0))

    (vector-set! max-left 0 (vector-ref dp 0))
    (for ([j (in-range 1 m)])
      (vector-set! max-left j (max (vector-ref max-left (- j 1)) (vector-ref dp j))))
    (vector-set! max-right (- m 1) (vector-ref dp (- m 1)))
    (for ([j (in-range (- m 2) -1 -1)])
      (vector-set! max-right j (max (vector-ref max-right (+ j 1)) (vector-ref dp j))))

    (for ([j (in-range m)])
      (vector-set! new-dp j (+ (vector-ref points i j)
                                (max (vector-ref max-left j)
                                     (vector-ref max-right j)))))
    (set! dp new-dp))

  (apply max (vector->list dp)))