(define (minimum-delete-sum s1 s2)
  (define n (string-length s1))
  (define m (string-length s2))
  (define dp (make-vector (+ n 1) (lambda () (make-vector (+ m 1) 0))))

  (for ((i (in-range (add1 n))))
    (vector-set! dp i (make-vector (+ m 1) 0)))

  (for ((j (in-range (add1 m))))
    (vector-set! (vector-ref dp 0) j (if (zero? j) 0 (+ (vector-ref (vector-ref dp 0) (- j 1)) (char->integer (string-ref s2 (- j 1)))))))

  (for ((i (in-range 1 (add1 n))))
    (for ((j (in-range 1 (add1 m))))
      (if (char=? (string-ref s1 (- i 1)) (string-ref s2 (- j 1)))
          (vector-set! (vector-ref dp i) j (vector-ref (vector-ref dp (- i 1)) (- j 1)))
          (vector-set! (vector-ref dp i) j (+ (min (vector-ref (vector-ref dp (- i 1)) j) (vector-ref (vector-ref dp i) (- j 1))) (char->integer (if (zero? j) (string-ref s1 (- i 1)) (string-ref s2 (- j 1)))))))))

  (vector-ref (vector-ref dp n) m))

(minimum-delete-sum "sea" "eat")