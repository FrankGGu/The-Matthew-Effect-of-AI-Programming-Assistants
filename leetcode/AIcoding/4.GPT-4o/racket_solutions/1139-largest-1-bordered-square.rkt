(define (largest1BorderedSquare grid)
  (define n (length grid))
  (define m (length (first grid)))
  (define dp (make-vector (+ n 1) (lambda () (make-vector (+ m 1) 0))))

  (for ([i (in-range n)]
        [j (in-range m)])
    (when (= (vector-ref (vector-ref grid i) j) 1)
      (vector-set! (vector-ref dp (+ i 1)) (+ j 1) (+ 1 (vector-ref (vector-ref dp (+ i 1)) (+ j 1))))
      (vector-set! (vector-ref dp (+ i 1)) (+ j 1) (max (vector-ref (vector-ref dp (+ i 1)) (+ j 1)) (vector-ref (vector-ref dp i) (+ j 1))))))

  (define max-side 0)

  (for ([i (in-range n)]
        [j (in-range m)])
    (for ([k (in-range (min (- n i) (- m j)))])
      (when (and (= (vector-ref (vector-ref dp (+ i 1)) (+ j 1)) (+ k 1))
                 (= (vector-ref (vector-ref dp (+ i (+ k 1))) (+ j 1)) (+ k 1))
                 (= (vector-ref (vector-ref dp (+ i 1)) (+ j (+ k 1))) (+ k 1))
                 (= (vector-ref (vector-ref dp (+ i (+ k 1))) (+ j (+ k 1))) (+ k 1)))
        (set! max-side (max max-side (+ k 1))))))

  (* max-side max-side))