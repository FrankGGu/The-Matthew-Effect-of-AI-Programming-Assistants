(define (nthSuperUglyNumber n primes)
  (define k (length primes))
  (define indices (make-vector k 0))
  (define ugly-numbers (vector 1))

  (define (next-ugly)
    (apply min (map (lambda (i) (* (vector-ref primes i) (vector-ref ugly-numbers (vector-ref indices i)))) (range k)))
    )

  (for ((i (in-range 1 n)))
    (define next (next-ugly))
    (vector-set! ugly-numbers i next)
    (for ((j (in-range k)))
      (when (= next (* (vector-ref primes j) (vector-ref ugly-numbers (vector-ref indices j))))
        (vector-set! indices j (+ (vector-ref indices j) 1)))))

  (vector-ref ugly-numbers (sub1 n)))