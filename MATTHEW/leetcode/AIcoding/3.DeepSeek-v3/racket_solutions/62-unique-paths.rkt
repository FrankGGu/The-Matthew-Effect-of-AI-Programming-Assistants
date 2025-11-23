(define (unique-paths m n)
  (let ([dp (make-vector m (make-vector n 1))])
    (for ([i (in-range 1 m)])
      (for ([j (in-range 1 n)])
        (vector-set! (vector-ref dp i) j 
                     (+ (vector-ref (vector-ref dp (- i 1)) j)
                        (vector-ref (vector-ref dp i) (- j 1))))))
    (vector-ref (vector-ref dp (- m 1)) (- n 1))))