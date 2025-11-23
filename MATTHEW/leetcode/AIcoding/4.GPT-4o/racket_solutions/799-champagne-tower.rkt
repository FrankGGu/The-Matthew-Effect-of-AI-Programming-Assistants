(define (champagne-tower poured query_row query_glass)
  (define tower (make-vector (+ 1 query_row) (lambda () (make-vector (+ 1 query_row) 0))))
  (vector-set! tower 0 (vector-set! (vector-ref tower 0) 0 poured))

  (for ([r (in-range 0 (+ query_row 1))])
    (for ([g (in-range 0 (+ r 1))])
      (define excess (max 0 (- (vector-ref (vector-ref tower r) g) 1)))
      (when (> excess 0)
        (vector-set! (vector-ref tower (+ r 1)) g (+ (vector-ref (vector-ref tower (+ r 1)) g) (/ excess 2.0)))
        (vector-set! (vector-ref tower (+ r 1)) (+ g 1) (+ (vector-ref (vector-ref tower (+ r 1)) (+ g 1)) (/ excess 2.0))))))

  (min 1.0 (vector-ref (vector-ref tower query_row) query_glass)))