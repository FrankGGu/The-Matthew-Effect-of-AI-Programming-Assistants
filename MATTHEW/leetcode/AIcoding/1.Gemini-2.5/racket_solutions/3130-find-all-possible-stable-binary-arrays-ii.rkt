#lang racket

(define (solve zero one limit)
  (define MOD 1000000007)

  ;; dp[i][j][0] = number of stable arrays with i zeros, j ones, ending with 0
  ;; dp[i][j][1] = number of stable arrays with i zeros, j ones, ending with 1
  (define dp (make-vector (+ zero 1)))
  (for ([i (in-range (+ zero 1))])
    (vector-set! dp i (make-vector (+ one 1))))
  (for ([i (in-range (+ zero 1))])
    (for ([j (in-range (+ one 1))])
      (vector-set! (vector-ref dp i) j (vector 0 0))))

  ;; prefix-sum-dp0[i][j] = sum of dp[i][y][0] for y from 0 to j (inclusive)
  (define prefix-sum-dp0 (make-vector (+ zero 1)))
  (for ([i (in-range (+ zero 1))])
    (vector-set! prefix-sum-dp0 i (make-vector (+ one 1) 0)))

  ;; prefix-sum-dp1[i][j] = sum of dp[x][j][1] for x from 0 to i (inclusive)
  (define prefix-sum-dp1 (make-vector (+ zero 1)))
  (for ([i (in-range (+ zero 1))])
    (vector-set! prefix-sum-dp1 i (make-vector (+ one 1) 0)))

  (for ([i (in-range (+ zero 1))])
    (for ([j (in-range (+ one 1))])

      (when (<= (abs (- i j)) limit)
        (cond
          [(and (> i 0) (= j 0)) ; Array consists only of zeros
           (when (<= i limit)
             (vector-set! (vector-ref (vector-ref dp i) j) 0 1))]
          [(and (= i 0) (> j 0)) ; Array consists only of ones
           (when (<= j limit)
             (vector-set! (vector-ref (vector-ref dp i) j) 1 1))]

          [(and (> i 0) (> j 0))
           ;; Calculate dp[i][j][0] (ending with '0')
           ;; Sum dp[x][j][1] for x from (i - max_k_0) to (i-1)
           ;; max_k_0 = min(limit, i, limit + i - j)
           (define max-k-0 (apply min (list limit i (+ limit i (- j)))))
           (when (> max-k-0 0)
             (define start-x (- i max-k-0))
             (define sum-val (vector-ref (vector-ref prefix-sum-dp1 (- i 1)) j))
             (when (>= (- start-x 1) 0)
               (set! sum-val (- sum-val (vector-ref (vector-ref prefix-sum-dp1 (- start-x 1)) j))))
             (vector-set! (vector-ref (vector-ref dp i) j) 0 (% (+ sum-val MOD) MOD)))

           ;; Calculate dp[i][j][1] (ending with '1')
           ;; Sum dp[i][y][0] for y from (j - max_k_1) to (j-1)
           ;; max_k_1 = min(limit, j, limit - i + j)
           (define max-k-1 (apply min (list limit j (+ limit (- i) j))))
           (when (> max-k-1 0)
             (define start-y (- j max-k-1))
             (define sum-val (vector-ref (vector-ref prefix-sum-dp0 i) (- j 1)))
             (when (>= (- start-y 1) 0)
               (set! sum-val (- sum-val (vector-ref (vector-ref prefix-sum-dp0 i) (- start-y 1)))))
             (vector-set! (vector-ref (vector-ref dp i) j) 1 (% (+ sum-val MOD) MOD))))))

      ;; Update prefix sums
      (vector-set! (vector-ref prefix-sum-dp0 i) j
                   (% (+ (if (> j 0) (vector-ref (vector-ref prefix-sum-dp0 i) (- j 1)) 0)
                         (vector-ref (vector-ref dp i) j 0))
                      MOD))
      (vector-set! (vector-ref prefix-sum-dp1 i) j
                   (% (+ (if (> i 0) (vector-ref (vector-ref prefix-sum-dp1 (- i 1)) j) 0)
                         (vector-ref (vector-ref dp i) j 1))
                      MOD))))

  (define result (% (+ (vector-ref (vector-ref dp zero) one 0)
                        (vector-ref (vector-ref dp zero) one 1))
                     MOD))
  result)