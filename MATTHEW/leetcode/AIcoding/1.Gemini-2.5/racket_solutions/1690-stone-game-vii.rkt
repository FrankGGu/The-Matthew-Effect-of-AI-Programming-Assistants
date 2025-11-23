(define (stoneGameVII stones)
  (define n (vector-length stones))

  (define prefix-sums (make-vector (+ n 1) 0))
  (for ([k (in-range n)])
    (vector-set! prefix-sums (+ k 1) (+ (vector-ref prefix-sums k) (vector-ref stones k))))

  (define (get-sum i j)
    (if (> i j)
        0
        (- (vector-ref prefix-sums (+ j 1)) (vector-ref prefix-sums i))))

  (define dp (make-vector n))
  (for ([k (in-range n)])
    (vector-set! dp k (make-vector n 0)))

  (for ([len (in-range 2 (+ n 1))])
    (for ([i (in-range (- n len))])
      (define j (+ i len -1))

      (define sum-i+1-j (get-sum (+ i 1) j))
      (define sum-i-j-1 (get-sum i (- j 1)))

      (define val1 (- sum-i+1-j (vector-ref (vector-ref dp (+ i 1)) j)))
      (define val2 (- sum-i-j-1 (vector-ref (vector-ref dp i) (- j 1))))

      (vector-set! (vector-ref dp i) j (max val1 val2))))

  (vector-ref (vector-ref dp 0) (- n 1)))