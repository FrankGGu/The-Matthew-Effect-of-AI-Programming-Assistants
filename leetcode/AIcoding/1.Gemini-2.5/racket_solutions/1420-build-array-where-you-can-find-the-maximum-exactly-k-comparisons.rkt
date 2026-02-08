(define (num-of-arrays n m k)
  (define MOD 1000000007)

  ;; dp[i][j][comp] = number of ways to build an array of length i,
  ;; where the maximum element is j, and exactly comp comparisons are made.
  ;; Dimensions: (n+1) x (m+1) x (k+1)
  (define dp (make-vector (+ n 1)))
  (for ([i (range (+ n 1))])
    (vector-set! dp i (make-vector (+ m 1)))
    (for ([j (range (+ m 1))])
      (vector-set! (vector-ref dp i) j (make-vector (+ k 1) 0))))

  ;; prefix-dp[i][comp][j] = sum(dp[i][p][comp] for p from 1 to j)
  ;; Dimensions: (n+1) x (k+1) x (m+1)
  (define prefix-dp (make-vector (+ n 1)))
  (for ([i (range (+ n 1))])
    (vector-set! prefix-dp i (make-vector (+ k 1)))
    (for ([comp (range (+ k 1))])
      (vector-set! (vector-ref prefix-dp i) comp (make-vector (+ m 1) 0))))

  ;; Base cases: For an array of length 1, max is j, 1 comparison.
  (for ([j (range 1 (+ m 1))])
    (vector-set! (vector-ref (vector-ref (vector-ref dp 1) j) 1) 1)
    ;; Update prefix-dp for i=1, comp=1
    (vector-set! (vector-ref (vector-ref (vector-ref prefix-dp 1) 1) j)
                 (modulo (+ (vector-ref (vector-ref (vector-ref dp 1) j) 1)
                            (if (> j 0) (vector-ref (vector-ref (vector-ref prefix-dp 1) 1) (- j 1)) 0))
                         MOD)))

  ;; Fill DP table
  (for ([i (range 2 (+ n 1))]) ;; Array length
    (for ([j (range 1 (+ m 1))]) ;; Maximum element in the array
      (for ([comp (range 1 (+ k 1))]) ;; Number of comparisons
        (let* ([current-dp-val 0]
               ;; Option 1: j is the new maximum.
               ;; This requires comp-1 comparisons for the first i-1 elements,
               ;; and their maximum must be less than j.
               ;; This sum is prefix-dp[i-1][comp-1][j-1].
               [new-max-ways (if (and (> comp 0) (> j 0))
                                 (if (> j 1)
                                     (vector-ref (vector-ref (vector-ref prefix-dp (- i 1)) (- comp 1)) (- j 1))
                                     0) ; If j=1, no p < j, so sum is 0
                                 0)] ; If comp=0, then sum is 0
               ;; Option 2: j was already the maximum.
               ;; We append an element x (1 <= x <= j). There are j choices.
               [prev-max-ways (vector-ref (vector-ref (vector-ref dp (- i 1)) j) comp)]
               [same-max-ways (modulo (* prev-max-ways j) MOD)])
          (set! current-dp-val (modulo (+ new-max-ways same-max-ways) MOD))
          (vector-set! (vector-ref (vector-ref (vector-ref dp i) j) comp) current-dp-val)

          ;; Update prefix-dp for current i and comp
          (vector-set! (vector-ref (vector-ref (vector-ref prefix-dp i) comp) j)
                       (modulo (+ current-dp-val
                                  (if (> j 0) (vector-ref (vector-ref (vector-ref prefix-dp i) comp) (- j 1)) 0))
                               MOD))))))

  ;; Final answer: sum(dp[n][j][k] for j from 1 to m)
  (let ([total-ways 0])
    (for ([j (range 1 (+ m 1))])
      (set! total-ways (modulo (+ total-ways (vector-ref (vector-ref (vector-ref dp n) j) k)) MOD)))
    total-ways))