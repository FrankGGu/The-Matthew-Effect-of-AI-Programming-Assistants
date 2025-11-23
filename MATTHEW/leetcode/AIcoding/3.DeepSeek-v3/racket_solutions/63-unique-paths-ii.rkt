(define/contract (unique-paths-with-obstacles obstacle-grid)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let* ([m (length obstacle-grid)]
         [n (if (zero? m) 0 (length (car obstacle-grid)))]
         [dp (make-vector m (make-vector n 0))])
    (for ([i (in-range m)])
      (for ([j (in-range n)])
        (cond
          [(= (list-ref (list-ref obstacle-grid i) j) 1)
           (vector-set! (vector-ref dp i) j 0)]
          [(and (zero? i) (zero? j))
           (vector-set! (vector-ref dp i) j 1)]
          [(zero? i)
           (vector-set! (vector-ref dp i) j (vector-ref (vector-ref dp i) (- j 1)))]
          [(zero? j)
           (vector-set! (vector-ref dp i) j (vector-ref (vector-ref dp (- i 1)) j))]
          [else
           (vector-set! (vector-ref dp i) j (+ (vector-ref (vector-ref dp (- i 1)) j)
                                              (vector-ref (vector-ref dp i) (- j 1))))]))))
    (if (or (zero? m) (zero? n))
        0
        (vector-ref (vector-ref dp (- m 1)) (- n 1)))))