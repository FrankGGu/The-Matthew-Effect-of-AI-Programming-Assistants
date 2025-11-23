(define/contract (min-path-sum grid)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let* ([m (length grid)]
         [n (length (car grid))]
         [dp (make-vector m (make-vector n 0))])
    (for ([i (in-range m)])
      (for ([j (in-range n)])
        (cond
          [(and (zero? i) (zero? j)) 
           (vector-set! (vector-ref dp i) j (list-ref (list-ref grid i) j))]
          [(zero? i) 
           (vector-set! (vector-ref dp i) j (+ (vector-ref (vector-ref dp i) (- j 1)) 
                                              (list-ref (list-ref grid i) j)))]
          [(zero? j) 
           (vector-set! (vector-ref dp i) j (+ (vector-ref (vector-ref dp (- i 1)) j) 
                                              (list-ref (list-ref grid i) j)))]
          [else 
           (vector-set! (vector-ref dp i) j (+ (min (vector-ref (vector-ref dp (- i 1)) j)
                                                   (vector-ref (vector-ref dp i) (- j 1)))
                                              (list-ref (list-ref grid i) j)))]))
    (vector-ref (vector-ref dp (- m 1)) (- n 1))))