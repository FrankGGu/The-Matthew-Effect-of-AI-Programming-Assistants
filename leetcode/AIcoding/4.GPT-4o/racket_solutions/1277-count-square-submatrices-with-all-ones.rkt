(define (countSquareSubmatrices matrix)
  (define rows (length matrix))
  (define cols (length (vector-ref matrix 0)))
  (define dp (make-vector rows (make-vector cols 0)))
  (define count 0)

  (for ([i (in-range rows)])
    (for ([j (in-range cols)])
      (when (= (vector-ref (vector-ref matrix i) j) 1)
        (define min-side (if (or (= i 0) (= j 0)) 1
                            (+ 1 (min (vector-ref (vector-ref dp (- i 1)) j)
                                       (vector-ref (vector-ref dp i) (- j 1))
                                       (vector-ref (vector-ref dp (- i 1)) (- j 1))))))
        (vector-set! (vector-ref dp i) j min-side)
        (set! count (+ count min-side)))))

  count)