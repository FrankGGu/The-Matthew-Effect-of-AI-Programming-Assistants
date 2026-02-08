(define (maximum-difference-score grid)
  (define m (vector-length grid))
  (define n (vector-length (vector-ref grid 0)))
  (define dp (make-vector m (make-vector n 0)))

  (vector-set! (vector-ref dp 0) 0 (vector-ref (vector-ref grid 0) 0))

  (for ([i (in-range 1 m)])
    (vector-set! (vector-ref dp i) 0 (+ (vector-ref (vector-ref dp (sub1 i)) 0) (vector-ref (vector-ref grid i) 0))))

  (for ([j (in-range 1 n)])
    (vector-set! (vector-ref dp 0) j (+ (vector-ref (vector-ref dp 0) (sub1 j)) (vector-ref (vector-ref grid 0) j))))

  (for ([i (in-range 1 m)])
    (for ([j (in-range 1 n)])
      (vector-set! (vector-ref dp i) j (+ (vector-ref (vector-ref grid i) j) (max (vector-ref (vector-ref dp (sub1 i)) j) (vector-ref (vector-ref dp i) (sub1 j))))))

  (define (helper i j)
    (cond
      [(or (< i 0) (< j 0)) -inf.0]
      [(and (= i 0) (= j 0)) (vector-ref (vector-ref grid 0) 0)]
      [else (+ (vector-ref (vector-ref grid i) j) (max (helper (sub1 i) j) (helper i (sub1 j))))]))

  (- (helper (sub1 m) (sub1 n)) (apply + (flatten (vector->list grid)))))