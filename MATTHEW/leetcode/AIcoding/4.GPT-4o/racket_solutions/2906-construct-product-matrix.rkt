(define (multiply A B)
  (let* ((rows-A (length A))
         (cols-A (length (car A)))
         (rows-B (length B))
         (cols-B (length (car B)))
         (result (make-vector rows-A (make-vector cols-B 0))))
    (if (not (= cols-A rows-B))
        (error "Incompatible matrices")
        (for ([i (in-range rows-A)]
              [j (in-range cols-B)]
              [k (in-range cols-A)])
          (vector-set! (vector-ref result i) j
                       (+ (vector-ref (vector-ref result i) j)
                          (* (vector-ref (vector-ref A i) k)
                             (vector-ref (vector-ref B k) j)))))
        result)))