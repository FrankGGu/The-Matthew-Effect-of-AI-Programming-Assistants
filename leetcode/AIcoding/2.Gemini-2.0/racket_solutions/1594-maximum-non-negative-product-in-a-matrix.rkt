(define (max-product grid)
  (define m (vector-length grid))
  (define n (vector-length (vector-ref grid 0)))

  (define min-dp (make-vector m (make-vector n 0)))
  (define max-dp (make-vector m (make-vector n 0)))

  (vector-ref (vector-ref min-dp 0) 0) (vector-ref (vector-ref grid 0) 0)
  (vector-ref (vector-ref max-dp 0) 0) (vector-ref (vector-ref grid 0) 0)

  (for ([i (in-range 1 m)])
    (let ([val (vector-ref (vector-ref grid i) 0)])
      (vector-ref (vector-ref min-dp i) 0) (* val (vector-ref (vector-ref min-dp (- i 1)) 0))
      (vector-ref (vector-ref max-dp i) 0) (* val (vector-ref (vector-ref max-dp (- i 1)) 0))))

  (for ([j (in-range 1 n)])
    (let ([val (vector-ref (vector-ref grid 0) j)])
      (vector-ref (vector-ref min-dp 0) j) (* val (vector-ref (vector-ref min-dp 0) (- j 1)))
      (vector-ref (vector-ref max-dp 0) j) (* val (vector-ref (vector-ref max-dp 0) (- j 1)))))

  (for ([i (in-range 1 m)]
        [j (in-range 1 n)])
    (let ([val (vector-ref (vector-ref grid i) j)])
      (let ([prev-min1 (* val (vector-ref (vector-ref min-dp (- i 1)) j))]
            [prev-max1 (* val (vector-ref (vector-ref max-dp (- i 1)) j))]
            [prev-min2 (* val (vector-ref (vector-ref min-dp i) (- j 1)))]
            [prev-max2 (* val (vector-ref (vector-ref max-dp i) (- j 1)))])
        (vector-ref (vector-ref min-dp i) j) (min prev-min1 prev-max1 prev-min2 prev-max2)
        (vector-ref (vector-ref max-dp i) j) (max prev-min1 prev-max1 prev-min2 prev-max2)))))

  (let ([res (vector-ref (vector-ref max-dp (- m 1)) (- n 1))])
    (if (< res 0)
        -1
        (modulo res 1000000007))))