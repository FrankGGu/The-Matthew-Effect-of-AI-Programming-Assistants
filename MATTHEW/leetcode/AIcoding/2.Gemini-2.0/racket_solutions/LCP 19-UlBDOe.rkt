(define (minimum-steps leaves)
  (define n (vector-length leaves))
  (define dp (make-vector n (make-vector 3 0)))

  (vector-set! (vector-ref dp 0) 0 (if (eqv? (vector-ref leaves 0) #\r) 1 0))
  (vector-set! (vector-ref dp 0) 1 +inf.0)
  (vector-set! (vector-ref dp 0) 2 +inf.0)

  (for ([i (in-range 1 n)])
    (define is-red? (eqv? (vector-ref leaves i) #\r))
    (define is-yellow? (not is-red?))

    (vector-set! (vector-ref dp i) 0 (+ (vector-ref (vector-ref dp (- i 1)) 0) (if is-red? 0 1)))
    (vector-set! (vector-ref dp i) 1 (min (+ (vector-ref (vector-ref dp (- i 1)) 0) (if is-yellow? 0 1))
                                        (+ (vector-ref (vector-ref dp (- i 1)) 1) (if is-yellow? 0 1))))
    (vector-set! (vector-ref dp i) 2 (min (+ (vector-ref (vector-ref dp (- i 1)) 1) (if is-red? 0 1))
                                        (+ (vector-ref (vector-ref dp (- i 1)) 2) (if is-red? 0 1)))))

  (vector-ref (vector-ref dp (- n 1)) 2))