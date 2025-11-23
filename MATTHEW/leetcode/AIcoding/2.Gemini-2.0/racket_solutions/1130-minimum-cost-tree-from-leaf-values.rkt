(define (mctFromLeafValues arr)
  (define n (length arr))
  (define dp (make-vector (add1 n) (make-vector (add1 n) 0)))
  (define max-val (make-vector (add1 n) (make-vector (add1 n) 0)))

  (for ([i (in-range n)])
    (vector-set! (vector-ref max-val i) (add1 i) (list-ref arr i)))

  (for ([len (in-range 2 (add1 n))])
    (for ([i (in-range (- n len -1))])
      (define j (+ i len))
      (vector-set! (vector-ref max-val i) j
                   (max (vector-ref arr i) (vector-ref (vector-ref max-val (add1 i)) j)))
      (define min-cost #f)
      (for ([k (in-range (add1 i) j)])
        (define cost (+ (vector-ref (vector-ref dp i) k)
                         (vector-ref (vector-ref dp k) j)
                         (* (vector-ref (vector-ref max-val i) k)
                            (vector-ref (vector-ref max-val k) j))))
        (if (or (not min-cost) (< cost min-cost))
            (set! min-cost cost)))
      (vector-set! (vector-ref dp i) j min-cost)))

  (vector-ref (vector-ref dp 0) n))