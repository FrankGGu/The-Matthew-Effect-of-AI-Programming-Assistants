(define/contract (connect-two-groups cost)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let* ([m (length cost)]
         [n (if (zero? m) 0 (length (car cost)))]
         [size (expt 2 n)]
         [dp (make-vector (expt 2 m) (make-vector size +inf.0))]
         [min-col (make-vector n +inf.0)])
    (for ([i (in-range m)])
      (for ([j (in-range n)])
        (vector-set! min-col j (min (vector-ref min-col j) (list-ref (list-ref cost i) j)))))
    (vector-set! (vector-ref dp 0) 0 0)
    (for ([mask (in-range (expt 2 m))])
      (for ([subset (in-range size)])
        (let ([current (vector-ref (vector-ref dp mask) subset)])
          (when (< current +inf.0)
            (for ([i (in-range m)])
              (when (zero? (bitwise-bit-field mask i 1))
                (for ([j (in-range n)])
                  (let* ([new-mask (bitwise-ior mask (expt 2 i))]
                         [new-subset (bitwise-ior subset (expt 2 j))]
                         [new-cost (+ current (list-ref (list-ref cost i) j))])
                    (when (< new-cost (vector-ref (vector-ref dp new-mask) new-subset))
                      (vector-set! (vector-ref dp new-mask) new-subset new-cost)))))))))))
    (let ([result +inf.0]
          [full-mask (sub1 (expt 2 m))])
      (for ([subset (in-range size)])
        (let ([total (vector-ref (vector-ref dp full-mask) subset)])
          (for ([j (in-range n)])
            (when (zero? (bitwise-bit-field subset j 1))
              (set! total (+ total (vector-ref min-col j)))))
          (set! result (min result total))))
      result)))