(define (unique-paths-with-obstacles obstacle-grid)
  (let* ([m (length obstacle-grid)]
         [n (length (car obstacle-grid))]
         [dp (make-vector m (make-vector n 0))])
    (if (= (vector-ref (vector-ref obstacle-grid 0) 0) 1)
        0
        (begin
          (vector-set! (vector-ref dp 0) 0 1)
          (for ([i (in-range 1 m)])
            (if (= (vector-ref (vector-ref obstacle-grid i) 0) 0)
                (vector-set! (vector-ref dp i) 0 (vector-ref (vector-ref dp (sub1 i)) 0))
                (vector-set! (vector-ref dp i) 0 0)))
          (for ([j (in-range 1 n)])
            (if (= (vector-ref (vector-ref obstacle-grid 0) j) 0)
                (vector-set! (vector-ref dp 0) j (vector-ref (vector-ref dp 0) (sub1 j)))
                (vector-set! (vector-ref dp 0) j 0)))
          (for ([i (in-range 1 m)])
            (for ([j (in-range 1 n)])
              (if (= (vector-ref (vector-ref obstacle-grid i) j) 0)
                  (vector-set! (vector-ref dp i) j (+ (vector-ref (vector-ref dp (sub1 i)) j) (vector-ref (vector-ref dp i) (sub1 j))))
                  (vector-set! (vector-ref dp i) j 0))))
          (vector-ref (vector-ref dp (sub1 m)) (sub1 n))))))