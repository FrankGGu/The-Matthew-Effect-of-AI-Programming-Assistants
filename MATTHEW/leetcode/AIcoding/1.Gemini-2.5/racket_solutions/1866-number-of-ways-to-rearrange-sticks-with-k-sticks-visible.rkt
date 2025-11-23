(define (num-ways-to-rearrange-sticks n k)
  (define mod 1000000007)

  ;; dp[i][j] will store the number of ways to arrange i sticks with j visible sticks.
  ;; i ranges from 0 to n, j ranges from 0 to k.
  (define dp (make-vector (+ n 1) #f))
  (for ([i (in-range (+ n 1))])
    (vector-set! dp i (make-vector (+ k 1) 0)))

  ;; Base case: 0 sticks, 0 visible sticks, 1 way (empty arrangement)
  (vector-set! (vector-ref dp 0) 0 1)

  ;; Fill the DP table
  (for ([i (in-range 1 (+ n 1))])
    (for ([j (in-range 1 (+ k 1))]) ; j cannot be 0 if i > 0, j cannot be > i
      (when (<= j i)
        (define term1 (vector-ref (vector-ref dp (- i 1)) (- j 1)))
        (define term2 (modulo (* (- i 1) (vector-ref (vector-ref dp (- i 1)) j)) mod))
        (define val (modulo (+ term1 term2) mod))
        (vector-set! (vector-ref dp i) j val))))

  (vector-ref (vector-ref dp n) k))