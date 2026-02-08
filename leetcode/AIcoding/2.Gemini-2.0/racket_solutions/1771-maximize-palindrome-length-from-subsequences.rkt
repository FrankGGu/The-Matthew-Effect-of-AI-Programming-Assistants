(define (max-palindrome-length s t)
  (define n (string-length s))
  (define m (string-length t))
  (define dp (make-vector (+ n m 1) (make-vector (+ n m 1) 0)))

  (for* ([i (in-range 1 (+ n m 1))]
         [j (in-range 1 (+ n m 1))])
    (define si (if (< i (+ n 1)) (string-ref s (- i 1)) (string-ref t (- i n 1))))
    (define sj (if (< j (+ n 1)) (string-ref s (- j 1)) (string-ref t (- j n 1))))
    (if (= si sj)
        (vector-set! (vector-ref dp i) j (+ 2 (vector-ref (vector-ref dp (- i 1)) (- j 1))))
        (vector-set! (vector-ref dp i) j (max (vector-ref (vector-ref dp (- i 1)) j) (vector-ref (vector-ref dp i) (- j 1))))))

  (vector-ref (vector-ref dp (+ n m)) (+ n m)))