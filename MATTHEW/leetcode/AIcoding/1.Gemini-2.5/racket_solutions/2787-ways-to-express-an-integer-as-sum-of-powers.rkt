(define (number-of-ways n x)
  (define MOD 1000000007)
  (define dp (make-vector (+ n 1) 0))
  (vector-set! dp 0 1)

  (let outer-loop ((i 1))
    (define p (expt i x))
    (when (<= p n)
      (let inner-loop ((j n))
        (when (>= j p)
          (vector-set! dp j
                       (modulo (+ (vector-ref dp j) (vector-ref dp (- j p))) MOD))
          (inner-loop (- j 1))))
      (outer-loop (+ i 1))))

  (vector-ref dp n))