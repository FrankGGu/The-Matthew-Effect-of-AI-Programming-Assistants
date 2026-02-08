(define (min3 a b c)
  (min a (min b c)))

(define (edit-distance s1 s2)
  (let* ((m (string-length s1))
         (n (string-length s2))
         (dp (make-vector (+ 1 m) (make-vector (+ 1 n) 0))))

    (for ((i (in-range (+ 1 m))))
      (vector-set! (vector-ref dp i) 0 i))

    (for ((j (in-range (+ 1 n))))
      (vector-set! (vector-ref dp 0) j j))

    (for ((i (in-range 1 (+ 1 m))))
      (for ((j (in-range 1 (+ 1 n))))
        (if (equal? (string-ref s1 (- i 1)) (string-ref s2 (- j 1)))
            (vector-set! (vector-ref dp i) j (vector-ref (vector-ref dp (- i 1)) (- j 1)))
            (vector-set! (vector-ref dp i) j (add1 (min3 (vector-ref (vector-ref dp (- i 1)) j)
                                                         (vector-ref (vector-ref dp i) (- j 1))
                                                         (vector-ref (vector-ref dp (- i 1)) (- j 1))))))))

    (vector-ref (vector-ref dp m) n)))