(define (unique-paths m n)
  (define dp (make-vector m))
  (for ([i (in-range m)])
    (vector-set! dp i (make-vector n)))

  (for ([j (in-range n)])
    (vector-set! (vector-ref dp 0) j 1))

  (for ([i (in-range m)])
    (vector-set! (vector-ref dp i) 0 1))

  (for ([i (in-range 1 m)])
    (for ([j (in-range 1 n)])
      (vector-set! (vector-ref dp i) j
                   (+ (vector-ref (vector-ref dp (- i 1)) j)
                      (vector-ref (vector-ref dp i) (- j 1))))))

  (vector-ref (vector-ref dp (- m 1)) (- n 1)))