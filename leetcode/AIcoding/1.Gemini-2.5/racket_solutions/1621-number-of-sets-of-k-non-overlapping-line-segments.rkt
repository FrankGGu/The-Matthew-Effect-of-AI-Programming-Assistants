#lang racket

(define (number-of-sets n k)
  (define MOD 1000000007)

  ;; S-prev-col stores S[i][j-1] values for the previous number of segments (j-1).
  ;; S[i][j] = sum_{p=0 to i} dp[p][j]
  ;; For j=0 (base case of 0 segments):
  ;; dp[p][0] = 1 (there is 1 way to choose 0 segments from points 0 to p)
  ;; So, S[i][0] = sum_{p=0 to i} 1 = i+1.
  (define S-prev-col (make-vector (+ n 1)))
  (for ([i (in-range (+ n 1))])
    (vector-set! S-prev-col i (add1 i)))

  ;; S-curr-col stores S[i][j] values for the current number of segments (j).
  (define S-curr-col (make-vector (+ n 1)))

  ;; Stores the final answer, dp[n][k].
  (define final-ans 0)

  ;; Iterate for the number of segments, from 1 to k.
  (for ([j (in-range 1 (add1 k))])
    ;; Base case for i=0:
    ;; dp[0][j] = 0 (no segments can be formed if only point 0 is available).
    ;; S[0][j] = dp[0][j] = 0.
    (vector-set! S-curr-col 0 0)

    ;; prev-dp-val stores dp[i-1][j] for the current 'j' iteration.
    ;; It's initialized to dp[0][j] which is 0.
    (define prev-dp-val 0)

    ;; Iterate for the rightmost point considered, from 1 to n.
    (for ([i (in-range 1 (add1 n))])
      ;; Calculate dp[i][j]: number of ways to form 'j' segments using points 0 to 'i'.
      ;; Recurrence: dp[i][j] = (dp[i-1][j] + S[i-1][j-1]) % MOD
      ;;   - dp[i-1][j] is prev-dp-val
      ;;   - S[i-1][j-1] is vector-ref S-prev-col (- i 1)
      (define current-dp-val (modulo (+ prev-dp-val (vector-ref S-prev-col (- i 1))) MOD))

      ;; Calculate S[i][j]: prefix sum of dp values for current 'j'.
      ;; Recurrence: S[i][j] = (S[i-1][j] + dp[i][j]) % MOD
      ;;   - S[i-1][j] is vector-ref S-curr-col (- i 1)
      ;;   - dp[i][j] is current-dp-val
      (vector-set! S-curr-col i (modulo (+ (vector-ref S-curr-col (- i 1)) current-dp-val) MOD))

      ;; Update prev-dp-val for the next iteration of 'i'.
      (set! prev-dp-val current-dp-val)

      ;; If this is the final iteration (j=k and i=n), store the result.
      (when (and (= j k) (= i n))
        (set! final-ans current-dp-val))
    )
    ;; After completing all 'i' for current 'j', S-curr-col becomes S-prev-col for the next 'j'.
    ;; vector-copy is crucial to prevent S-prev-col from referencing the same mutable vector as S-curr-col.
    (set! S-prev-col (vector-copy S-curr-col))
  )
  final-ans)