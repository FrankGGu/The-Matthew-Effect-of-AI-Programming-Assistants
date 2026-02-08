(define (nth-super-ugly-number n primes-list)
  (define num-primes (length primes-list))
  (define primes (list->vector primes-list))

  (define ugly (make-vector n 0))
  (vector-set! ugly 0 1)

  (define pointers (make-vector num-primes 0))

  (for ([i (in-range 1 n)])
    (define min-val +inf.0)

    (for ([j (in-range num-primes)])
      (define candidate (* (vector-ref ugly (vector-ref pointers j))
                           (vector-ref primes j)))
      (when (< candidate min-val)
        (set! min-val candidate)))

    (vector-set! ugly i min-val)

    (for ([j (in-range num-primes)])
      (when (= (* (vector-ref ugly (vector-ref pointers j))
                  (vector-ref primes j))
               min-val)
        (vector-set! pointers j (+ (vector-ref pointers j) 1)))))

  (vector-ref ugly (- n 1)))