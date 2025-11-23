(define (paths-in-matrix grid k)
  (define MOD 1000000007)
  (define m (length grid))
  (define n (length (car grid)))

  ;; dp[r][c][rem] stores the number of paths from (0,0) to (r,c)
  ;; such that the sum of elements along the path has a remainder 'rem' when divided by 'k'.
  (define dp (make-vector m))
  (for ([r (in-range m)])
    (vector-set! dp r (make-vector n))
    (for ([c (in-range n)])
      (vector-set! (vector-ref dp r) c (make-vector k 0))))

  ;; Base case: starting cell (0, 0)
  (define initial-rem (modulo (list-ref (list-ref grid 0) 0) k))
  (vector-set! (vector-ref (vector-ref (vector-ref dp 0) 0) initial-rem) 1)

  ;; Fill DP table using a "push" approach
  (for ([r (in-range m)])
    (for ([c (in-range n)])
      (for ([prev-rem (in-range k)])
        (define current-dp-val (vector-ref (vector-ref (vector-ref dp r) c) prev-rem))

        ;; If there are paths to (r, c) with remainder prev-rem
        (when (> current-dp-val 0)
          ;; Try to move right to (r, c+1)
          (when (< (+ c 1) n)
            (define next-c (+ c 1))
            (define next-cell-val (list-ref (list-ref grid r) next-c))
            (define new-rem (modulo (+ prev-rem next-cell-val) k))
            (vector-set! (vector-ref (vector-ref (vector-ref dp r) next-c) new-rem)
                         (modulo (+ (vector-ref (vector-ref (vector-ref dp r) next-c) new-rem) current-dp-val) MOD)))

          ;; Try to move down to (r+1, c)
          (when (< (+ r 1) m)
            (define next-r (+ r 1))
            (define next-cell-val (list-ref (list-ref grid next-r) c))
            (define new-rem (modulo (+ prev-rem next-cell-val) k))
            (vector-set! (vector-ref (vector-ref (vector-ref dp next-r) c) new-rem)
                         (modulo (+ (vector-ref (vector-ref (vector-ref dp next-r) c) new-rem) current-dp-val) MOD)))))))

  ;; The result is the number of paths to the bottom-right cell (m-1, n-1)
  ;; whose sum has a remainder of 0 when divided by k.
  (vector-ref (vector-ref (vector-ref dp (- m 1)) (- n 1)) 0))