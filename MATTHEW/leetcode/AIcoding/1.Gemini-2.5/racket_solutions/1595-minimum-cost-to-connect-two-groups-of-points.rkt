(define (connect-two-groups cost)
  (define m (length cost))
  (define n (length (car cost)))

  (define cost-vec
    (build-vector m (lambda (i)
                      (list->vector (list-ref cost i)))))

  (define min-cost-group2 (make-vector n +inf.0))
  (for ([j (in-range n)])
    (for ([k (in-range m)])
      (vector-set! min-cost-group2 j
                   (min (vector-ref min-cost-group2 j)
                        (vector-ref (vector-ref cost-vec k) j)))))

  (define dp (build-vector (+ m 1) (lambda (i) (make-vector (expt 2 n) +inf.0))))

  (vector-set! (vector-ref dp 0) 0 0)

  (for ([i (in-range m)])
    (for ([mask (in-range (expt 2 n))])
      (when (< (vector-ref (vector-ref dp i) mask) +inf.0)
        (for ([j (in-range n)])
          (define new-mask (bitwise-ior mask (arithmetic-shift 1 j)))
          (define current-cost (+ (vector-ref (vector-ref dp i) mask)
                                  (vector-ref (vector-ref cost-vec i) j)))
          (when (< current-cost (vector-ref (vector-ref dp (+ i 1)) new-mask))
            (vector-set! (vector-ref dp (+ i 1)) new-mask current-cost))))))

  (define result +inf.0)
  (for ([mask (in-range (expt 2 n))])
    (when (< (vector-ref (vector-ref dp m) mask) +inf.0)
      (define current-total-cost (vector-ref (vector-ref dp m) mask))
      (for ([j (in-range n)])
        (when (= (bitwise-and (arithmetic-shift 1 j) mask) 0)
          (set! current-total-cost (+ current-total-cost (vector-ref min-cost-group2 j)))))
      (set! result (min result current-total-cost))))

  result)