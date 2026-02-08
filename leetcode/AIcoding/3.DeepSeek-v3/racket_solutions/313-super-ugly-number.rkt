(define/contract (nth-super-ugly-number n primes)
  (-> exact-integer? (listof exact-integer?) exact-integer?)
  (let ([uglies (make-vector n 1)]
        [pointers (make-vector (length primes) 0)]
        [primes-vec (list->vector primes)])
    (for ([i (in-range 1 n)])
      (let ([next-ugly (for/fold ([min-val +inf.0]) ([j (in-range (length primes))])
                         (min min-val (* (vector-ref primes-vec j) (vector-ref uglies (vector-ref pointers j)))))])
        (vector-set! uglies i next-ugly)
        (for ([j (in-range (length primes))])
          (when (= next-ugly (* (vector-ref primes-vec j) (vector-ref uglies (vector-ref pointers j))))
            (vector-set! pointers j (+ (vector-ref pointers j) 1))))))
    (vector-ref uglies (- n 1))))