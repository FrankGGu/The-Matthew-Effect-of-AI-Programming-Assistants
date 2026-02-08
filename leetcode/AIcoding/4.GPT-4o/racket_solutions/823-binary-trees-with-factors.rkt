(define (numFactoredBinaryTrees arr)
  (define mod 1000000007)
  (define sorted-arr (sort < arr))
  (define n (length sorted-arr))
  (define dp (make-vector n 1))
  (define index-map (hash))

  (for ([i (in-range n)])
    (hash-set! index-map (vector-ref sorted-arr i) i))

  (for ([i (in-range n)])
    (for ([j (in-range i)])
      (define left (vector-ref sorted-arr j))
      (define right (vector-ref sorted-arr (- i j 1)))
      (when (= (vector-ref sorted-arr i) (* left right))
        (vector-set! dp i (mod (+ (vector-ref dp i) (* (vector-ref dp j) (vector-ref dp (- i j 1)))) mod)))))

  (apply + (vector->list dp)))