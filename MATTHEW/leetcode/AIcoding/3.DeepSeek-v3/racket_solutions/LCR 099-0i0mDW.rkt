(define/contract (min-path-sum grid)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let* ([m (length grid)]
         [n (length (car grid))]
         [dp (make-vector m (make-vector n 0))])
    (vector-set! (vector-ref dp 0) 0 (list-ref (list-ref grid 0) 0))
    (for ([i (in-range 1 m)])
      (vector-set! (vector-ref dp i) 0 (+ (vector-ref (vector-ref dp (- i 1)) 0) (list-ref (list-ref grid i) 0)))
    (for ([j (in-range 1 n)])
      (vector-set! (vector-ref dp 0) j (+ (vector-ref (vector-ref dp 0) (- j 1)) (list-ref (list-ref grid 0) j)))
    (for ([i (in-range 1 m)])
      (for ([j (in-range 1 n)])
        (vector-set! (vector-ref dp i) j (+ (min (vector-ref (vector-ref dp (- i 1)) j) (vector-ref (vector-ref dp i) (- j 1))) (list-ref (list-ref grid i) j))))
    (vector-ref (vector-ref dp (- m 1)) (- n 1))))