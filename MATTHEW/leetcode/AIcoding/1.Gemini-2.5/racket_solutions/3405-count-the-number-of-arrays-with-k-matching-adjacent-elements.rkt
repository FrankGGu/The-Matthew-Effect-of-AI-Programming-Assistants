#lang racket

(define (count-matching-subarrays n m k)
  (define MOD 1000000007)

  ;; dp[i][j][p] = number of arrays of length i, ending with value j, having p matching adjacent elements
  ;; i: 1 to n (array length)
  ;; j: 1 to m (last element value)
  ;; p: 0 to k (number of matches)
  (define dp
    (make-vector (+ n 1)
                 (lambda ()
                   (make-vector (+ m 1)
                                (lambda ()
                                  (make-vector (+ k 1) 0))))))

  ;; Base case: arrays of length 1
  ;; dp[1][j][0] = 1 for all j from 1 to m
  (for ([j (in-range 1 (+ m 1))])
    (vector-set! (vector-ref (vector-ref dp 1) j) 0 1))

  ;; Fill DP table for lengths from 2 to n
  (for ([i (in-range 2 (+ n 1))])
    (for ([p (in-range 0 (+ k 1))])
      ;; Calculate sum_dp_i_minus_1_p = sum(dp[i-1][val][p] for val in 1..m)
      ;; This is the sum of counts for arrays of length (i-1) with 'p' matches, regardless of their last element.
      (define sum-dp-i-minus-1-p 0)
      (for ([val (in-range 1 (+ m 1))])
        (set! sum-dp-i-minus-1-p
              (modulo (+ sum-dp-i-minus-1-p
                         (vector-ref (vector-ref (vector-ref dp (- i 1)) val) p))
                      MOD)))

      ;; Calculate dp[i][j][p] for current i and p, for all j
      (for ([j (in-range 1 (+ m 1))])
        (define current-val 0)

        ;; Case 1: The (i-1)-th element was 'j'.
        ;; If the previous element was 'j', then adding 'j' as the i-th element creates a new match.
        ;; So, we look for arrays of length (i-1) ending with 'j' and having (p-1) matches.
        (when (> p 0)
          (set! current-val
                (modulo (+ current-val
                           (vector-ref (vector-ref (vector-ref dp (- i 1)) j) (- p 1)))
                        MOD)))

        ;; Case 2: The (i-1)-th element was NOT 'j'.
        ;; If the previous element was not 'j', then adding 'j' as the i-th element does not create a new match.
        ;; So, we look for arrays of length (i-1) ending with any value other than 'j' and having 'p' matches.
        ;; This is (sum_dp_i_minus_1_p - dp[i-1][j][p]).
        (define term2
          (modulo (+ (- sum-dp-i-minus-1-p
                        (vector-ref (vector-ref (vector-ref dp (- i 1)) j) p))
                     MOD) ; Add MOD to handle potential negative result from subtraction before final modulo
                  MOD))

        (set! current-val
              (modulo (+ current-val term2) MOD))

        (vector-set! (vector-ref (vector-ref dp i) j) p current-val))))

  ;; The final answer is the sum of all dp[n][j][k] for j from 1 to m.
  ;; This represents all arrays of length 'n' with 'k' matches, regardless of their last element.
  (define total-count 0)
  (for ([j (in-range 1 (+ m 1))])
    (set! total-count
          (modulo (+ total-count
                     (vector-ref (vector-ref (vector-ref dp n) j) k))
                  MOD)))

  total-count)