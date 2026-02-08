(define (longest-palindromic-subsequence s)
  (define n (string-length s))
  (define dp (make-vector n (make-vector n 0)))

  (for ([i (in-range n)])
    (vector-set! (vector-ref dp i) i 1))

  (for ([length (in-range 2 (+ 1 n))])
    (for ([i (in-range (- n length 1))])
      (define j (+ i length -1))
      (if (equal? (string-ref s i) (string-ref s j))
          (vector-set! (vector-ref dp i) j (+ 2 (vector-ref (vector-ref dp (+ i 1)) (- j 1))))
          (vector-set! (vector-ref dp i) j (max (vector-ref (vector-ref dp i) (- j 1)) (vector-ref (vector-ref dp (+ i 1)) j))))))

  (vector-ref (vector-ref dp 0) (- n 1)))