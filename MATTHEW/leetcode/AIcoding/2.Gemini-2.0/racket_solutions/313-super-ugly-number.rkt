(define (nth-super-ugly-number n primes)
  (let* ([k (length primes)]
         [ugly-numbers (make-vector n 1)]
         [indices (make-vector k 0)]
         [values (make-vector k 0)])
    (for ([i (in-range k)])
      (vector-set! values i (vector-ref primes i)))
    (for ([i (in-range 1 n)])
      (let* ([min-val (apply min (vector->list values))]
             [min-indices (filter-map (lambda (j)
                                         (if (= (vector-ref values j) min-val)
                                             j
                                             #f))
                                       (in-range k))])
        (vector-set! ugly-numbers i min-val)
        (for ([j min-indices])
          (let loop ()
            (vector-set! indices j (+ 1 (vector-ref indices j)))
            (if (= (vector-ref ugly-numbers (vector-ref indices j)) (vector-ref ugly-numbers (- i 1)))
                (loop)
                (vector-set! values j (* (vector-ref primes j) (vector-ref ugly-numbers (vector-ref indices j))))))))))
    (vector-ref ugly-numbers (- n 1))))