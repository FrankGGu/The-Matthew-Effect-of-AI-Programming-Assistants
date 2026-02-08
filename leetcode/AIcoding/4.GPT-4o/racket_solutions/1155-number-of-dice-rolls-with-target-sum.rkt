(define (numRollsToTarget d f target)
  (define mod 1000000007)
  (define dp (make-vector (+ 1 d) (make-vector (+ 1 target) 0)))
  (vector-set! dp 0 1)

  (for ([i (in-range 1 (+ 1 d))])
    (for ([j (in-range 1 (+ 1 target))])
      (for ([k (in-range 1 (+ 1 f))])
        (when (>= j k)
          (vector-set! dp i (vector-set! (vector-ref dp i) j 
                                          (mod (+ (vector-ref (vector-ref dp (- i 1)) (- j k)) 
                                                   (vector-ref dp i j)) mod)))))
      ))
    )

  (vector-ref (vector-ref dp d) target))