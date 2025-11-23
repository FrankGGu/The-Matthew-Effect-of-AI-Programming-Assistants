(define (count-special-subsequences nums)
  (define mod 1000000007)
  (define z (make-vector 3 0))
  (vector-set! z 0 1)
  (for ([num nums])
    (cond
      [(equal? num 0) (vector-set! z 0 (modulo (+ (* 2 (vector-ref z 0)) (vector-ref z 0)) mod))]
      [(equal? num 1) (vector-set! z 1 (modulo (+ (* 2 (vector-ref z 1)) (vector-ref z 0)) mod))]
      [else (vector-set! z 2 (modulo (+ (* 2 (vector-ref z 2)) (vector-ref z 1)) mod))]))
  (vector-ref z 2))