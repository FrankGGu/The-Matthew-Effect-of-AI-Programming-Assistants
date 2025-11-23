(define (max-coins bags k)
  (define n (length bags))
  (define dp (make-vector (add1 k) (make-vector (add1 n) 0)))

  (for* ([i (range 1 (add1 k))]
         [j (range 1 (add1 n))])
    (define bag (list-ref bags (sub1 j)))
    (define m (length bag))
    (for ([x (range 0 (min (add1 i) (add1 m)))])
      (define current-coins (if (zero? x) 0 (list-ref bag (sub1 x))))
      (vector-set! (vector-ref dp i j)
                   (max (vector-ref (vector-ref dp i (sub1 j)) i)
                        (+ current-coins (vector-ref (vector-ref dp (sub1 i) (sub1 j)) (- i x)))))))

  (vector-ref (vector-ref dp k n) k))