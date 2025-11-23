(define (min-insertions s)
  (define n (string-length s))
  (define dp (make-vector (+ n 1) (make-vector (+ n 1) 0)))

  (for* ([i (in-range (- n 1) -1 -1)]
         [j (in-range (+ i 1) n)])
    (if (char=? (string-ref s i) (string-ref s j))
        (vector-set! (vector-ref dp i) j (vector-ref (vector-ref dp (+ i 1)) (- j 1)))
        (vector-set! (vector-ref dp i) j (+ 1 (min (vector-ref (vector-ref dp (+ i 1)) j) (vector-ref (vector-ref dp i) (- j 1)))))))

  (vector-ref (vector-ref dp 0) (- n 1)))