(define (numDistinct s t)
  (define m (string-length s))
  (define n (string-length t))
  (define dp (make-vector (+ 1 m) (make-vector (+ 1 n) 0)))

  (for ([i (in-range (+ 1 m))])
    (vector-set! dp i 0))
  (for ([j (in-range (+ 1 n))])
    (vector-set! (vector-ref dp 0) j 0))

  (vector-set! (vector-ref dp 0) 0 1)

  (for ([i (in-range 1 (+ 1 m))])
    (vector-set! dp i 0 1))

  (for ([i (in-range 1 (+ 1 m))])
    (for ([j (in-range 1 (+ 1 n))])
      (if (char=? (string-ref s (- i 1)) (string-ref t (- j 1)))
          (vector-set! (vector-ref dp i) j (+ (vector-ref (vector-ref dp (- i 1)) j) (vector-ref (vector-ref dp (- i 1)) (- j 1))))
          (vector-set! (vector-ref dp i) j (vector-ref (vector-ref dp (- i 1)) j)))))

  (vector-ref (vector-ref dp m) n))