(define/contract (count-submatrices grid k)
  (-> (listof (listof exact-integer?)) exact-integer? exact-integer?)
  (let* ([m (length grid)]
         [n (length (car grid))]
         [prefix (make-vector m (make-vector n 0))])
    (for ([i (in-range m)])
      (for ([j (in-range n)])
        (let ([val (list-ref (list-ref grid i) j)]
              [top (if (> i 0) (vector-ref (vector-ref prefix (- i 1)) j) 0)]
              [left (if (> j 0) (vector-ref (vector-ref prefix i) (- j 1)) 0)]
              [topleft (if (and (> i 0) (> j 0)) (vector-ref (vector-ref prefix (- i 1)) (- j 1)) 0)])
          (vector-set! (vector-ref prefix i) j (+ val top left (- topleft))))))
    (let loop ([i 0] [j 0] [res 0])
      (cond
        [(>= i m) res]
        [(>= j n) (loop (+ i 1) 0 res)]
        [else
         (let ([sum (vector-ref (vector-ref prefix i) j)])
           (if (< sum k)
               (loop i (+ j 1) (+ res 1))
               (loop i (+ j 1) res)))]))))