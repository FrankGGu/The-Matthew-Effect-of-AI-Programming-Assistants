(define (die-roll-simulation n roll-maxes)
  (define m (length roll-maxes))
  (define MOD 1000000007)

  (define dp (make-vector (add1 n) (make-vector m 0)))
  (define sum-dp (make-vector (add1 n) 0))

  (for ((i m))
    (vector-set! (vector-ref dp 1) i 1))
  (vector-set! sum-dp 1 m)

  (for ((i (range 2 (add1 n))))
    (let loop ((j (range m)))
      (let ((max-consecutive (vector-ref roll-maxes j)))
        (let ((valid-ways (modulo (- (vector-ref sum-dp (sub1 i)) (if (>= i max-consecutive) (vector-ref (vector-ref dp (- i max-consecutive)) j) 0)) MOD)))
          (vector-set! (vector-ref dp i) j valid-ways)
          (vector-set! sum-dp i (modulo (+ (vector-ref sum-dp i) valid-ways) MOD)))))
    )

  (vector-ref sum-dp n))