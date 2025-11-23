(define (max-dot-product A B)
  (define n (length A))
  (define m (length B))
  (define dp (make-vector (+ 1 n) (lambda () (make-vector (+ 1 m) 0))))
  (for ([i (in-range 1 (+ 1 n))])
    (for ([j (in-range 1 (+ 1 m))])
      (define current-product (* (vector-ref A (- i 1)) (vector-ref B (- j 1))))
      (vector-set! (vector-ref dp i) j
        (max (vector-ref (vector-ref dp (- i 1)) j)
             (vector-ref (vector-ref dp i) (- j 1))
             (vector-ref (vector-ref dp (- i 1)) (- j 1))
             current-product
             (+ current-product (vector-ref (vector-ref dp (- i 1)) (- j 1)))))))
  (vector-ref (vector-ref dp n) m))

(max-dot-product A B)