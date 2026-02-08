(define (count-good-meals deliciousness)
  (define MOD 1000000007)

  (define powers-of-two
    (for/list ([i (in-range 22)]) ; Powers of 2 from 2^0 to 2^21
      (expt 2 i)))

  (define freq-map (make-hash))
  (for-each (lambda (d)
              (hash-update! freq-map d add1 0))
            deliciousness)

  (define total-good-meals 0)

  (for-each (lambda (d1)
              (define c1 (hash-ref freq-map d1))
              (for-each (lambda (p)
                          (define d2 (- p d1))
                          (when (hash-has-key? freq-map d2)
                            (define c2 (hash-ref freq-map d2))
                            (cond
                              [(and (= d1 d2) (>= d1 0))
                               (set! total-good-meals
                                     (modulo (+ total-good-meals
                                                  (quotient (* c1 (- c1 1)) 2))
                                              MOD))]
                              [(< d1 d2)
                               (set! total-good-meals
                                     (modulo (+ total-good-meals
                                                  (* c1 c2))
                                              MOD))])))
                        powers-of-two))
            (hash-keys freq-map))

  total-good-meals)