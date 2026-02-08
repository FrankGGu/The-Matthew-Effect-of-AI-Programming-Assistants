(define/contract (largest-magic-square grid)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (define m (length grid))
  (define n (if (zero? m) 0 (length (car grid))))
  (define row-sum (make-vector m (make-vector n 0)))
  (define col-sum (make-vector m (make-vector n 0)))
  (define diag1-sum (make-vector m (make-vector n 0)))
  (define diag2-sum (make-vector m (make-vector n 0)))

  (for ([i (in-range m)])
    (for ([j (in-range n)])
      (vector-set! (vector-ref row-sum i) j 
                   (if (zero? j) 
                       (list-ref (list-ref grid i) j)
                       (+ (list-ref (list-ref grid i) j) 
                          (vector-ref (vector-ref row-sum i) (- j 1)))))))

  (for ([j (in-range n)])
    (for ([i (in-range m)])
      (vector-set! (vector-ref col-sum i) j 
                   (if (zero? i) 
                       (list-ref (list-ref grid i) j)
                       (+ (list-ref (list-ref grid i) j) 
                          (vector-ref (vector-ref col-sum (- i 1)) j))))))

  (for ([i (in-range m)])
    (for ([j (in-range n)])
      (vector-set! (vector-ref diag1-sum i) j 
                   (if (or (zero? i) (zero? j)) 
                       (list-ref (list-ref grid i) j)
                       (+ (list-ref (list-ref grid i) j) 
                          (vector-ref (vector-ref diag1-sum (- i 1)) (- j 1)))))))

  (for ([i (in-range m)])
    (for ([j (in-range (- n 1) -1 -1)])
      (vector-set! (vector-ref diag2-sum i) j 
                   (if (or (zero? i) (= j (- n 1))) 
                       (list-ref (list-ref grid i) j)
                       (+ (list-ref (list-ref grid i) j) 
                          (vector-ref (vector-ref diag2-sum (- i 1)) (+ j 1)))))))

  (define max-size 1)

  (for ([i (in-range m)])
    (for ([j (in-range n)])
      (for ([k (in-range (min (- m i) (- n j)) 1 -1)])
        (define target (let ([r1 (if (zero? j) 
                                    (vector-ref (vector-ref row-sum i) (+ j k -1))
                                    (- (vector-ref (vector-ref row-sum i) (+ j k -1)) 
                                       (vector-ref (vector-ref row-sum i) (- j 1))))]
                         [r2 (if (zero? j) 
                                (vector-ref (vector-ref row-sum (+ i k -1)) (+ j k -1))
                                (- (vector-ref (vector-ref row-sum (+ i k -1)) (+ j k -1)) 
                                   (vector-ref (vector-ref row-sum (+ i k -1)) (- j 1))))]
                         [c1 (if (zero? i) 
                                (vector-ref (vector-ref col-sum (+ i k -1)) j)
                                (- (vector-ref (vector-ref col-sum (+ i k -1)) j) 
                                   (vector-ref (vector-ref col-sum (- i 1)) j)))]
                         [c2 (if (zero? i) 
                                (vector-ref (vector-ref col-sum (+ i k -1)) (+ j k -1))
                                (- (vector-ref (vector-ref col-sum (+ i k -1)) (+ j k -1)) 
                                   (vector-ref (vector-ref col-sum (- i 1)) (+ j k -1))))]
                         [d1 (vector-ref (vector-ref diag1-sum (+ i k -1)) (+ j k -1))]
                         [d2 (vector-ref (vector-ref diag2-sum (+ i k -1)) j)])
                         (and (= r1 r2 c1 c2 d1 d2) r1)))
        (when (and target (> k max-size))
          (set! max-size k))))))

  max-size)