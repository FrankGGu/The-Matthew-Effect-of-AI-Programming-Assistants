(define (minimumCost s1 s2 cost)
  (define n (string-length s1))
  (define dp (make-vector (+ n 1) 0))

  (for ([i (in-range (+ n 1))])
    (vector-set! dp i i))

  (for ([i (in-range n)])
    (for ([j (in-range (+ n 1))])
      (if (and (< j n) (= (string-ref s1 i) (string-ref s2 j)))
          (vector-set! dp j (min (vector-ref dp j) (vector-ref dp j 1)))
          (vector-set! dp j (+ (vector-ref dp j) cost)))))

  (vector-ref dp n))

(define (minimumCostToConvertStringII s1 s2 cost)
  (minimumCost s1 s2 cost))