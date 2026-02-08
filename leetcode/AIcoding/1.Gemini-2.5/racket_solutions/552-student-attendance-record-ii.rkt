(define (check-record n)
  (define MOD 1000000007)

  (define dp-prev (make-vector 2))
  (define dp-curr (make-vector 2))

  (for ([j (in-range 2)])
    (vector-set! dp-prev j (make-vector 3 0))
    (vector-set! dp-curr j (make-vector 3 0)))

  (vector-set! (vector-ref dp-prev 0) 0 1)

  (for ([i (in-range 1 (+ n 1))])
    ;; For records with 0 'A's
    (vector-set! (vector-ref (vector-ref dp-curr 0) 0)
                 (modulo (+ (vector-ref (vector-ref dp-prev 0) 0)
                            (vector-ref (vector-ref dp-prev 0) 1)
                            (vector-ref (vector-ref dp-prev 0) 2))
                         MOD))

    (vector-set! (vector-ref (vector-ref dp-curr 0) 1)
                 (vector-ref (vector-ref dp-prev 0) 0))

    (vector-set! (vector-ref (vector-ref dp-curr 0) 2)
                 (vector-ref (vector-ref dp-prev 0) 1))

    ;; For records with 1 'A'
    (vector-set! (vector-ref (vector-ref dp-curr 1) 0)
                 (modulo (+ (vector-ref (vector-ref dp-prev 1) 0)
                            (vector-ref (vector-ref dp-prev 1) 1)
                            (vector-ref (vector-ref dp-prev 1) 2)
                            (vector-ref (vector-ref dp-prev 0) 0)
                            (vector-ref (vector-ref dp-prev 0) 1)
                            (vector-ref (vector-ref dp-prev 0) 2))
                         MOD))

    (vector-set! (vector-ref (vector-ref dp-curr 1) 1)
                 (vector-ref (vector-ref dp-prev 1) 0))

    (vector-set! (vector-ref (vector-ref dp-curr 1) 2)
                 (vector-ref (vector-ref dp-prev 1) 1))

    (define temp dp-prev)
    (set! dp-prev dp-curr)
    (set! dp-curr temp))

  (modulo (+ (vector-ref (vector-ref dp-prev 0) 0)
             (vector-ref (vector-ref dp-prev 0) 1)
             (vector-ref (vector-ref dp-prev 0) 2)
             (vector-ref (vector-ref dp-prev 1) 0)
             (vector-ref (vector-ref dp-prev 1) 1)
             (vector-ref (vector-ref dp-prev 1) 2))
          MOD))