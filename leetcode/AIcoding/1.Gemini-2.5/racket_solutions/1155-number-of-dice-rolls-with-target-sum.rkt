(define (num-rolls-to-target n f target)
  (define MOD 1000000007)

  ;; dp table: (n+1) x (target+1)
  ;; dp[i][j] will store the number of ways to get sum j with i dice
  (define dp (make-vector (+ n 1)))

  ;; Initialize dp table with vectors of zeros
  (for ([i (in-range (+ n 1))])
    (vector-set! dp i (make-vector (+ target 1) 0)))

  ;; Base case: 0 dice, sum 0 -> 1 way (do nothing)
  (vector-set! (vector-ref dp 0) 0 1)

  ;; Iterate through number of dice
  (for ([i (in-range 1 (+ n 1))])
    ;; Iterate through possible sums
    (for ([j (in-range 1 (+ target 1))])
      ;; Iterate through face values of the current die
      (for ([k (in-range 1 (+ f 1))])
        (when (>= (- j k) 0)
          (let* ([prev-sum-ways (vector-ref (vector-ref dp (- i 1)) (- j k))]
                 [current-ways (vector-ref (vector-ref dp i) j)])
            (vector-set! (vector-ref dp i) j
                         (modulo (+ current-ways prev-sum-ways) MOD)))))))

  ;; The result is dp[n][target]
  (vector-ref (vector-ref dp n) target))