#lang racket

(define (get-money-amount n)
  (define dp (make-vector (+ n 1) (lambda () (make-vector (+ n 1) 0))))

  ;; dp[i][j] represents the minimum cost to guarantee a win
  ;; when the secret number is within the range [i, j].

  ;; Iterate over the length of the interval (len)
  ;; len goes from 2 up to n (inclusive)
  (for ([len (in-range 2 (+ n 1))])
    ;; Iterate over the starting point of the interval (i)
    ;; i goes from 1 up to n - len + 1 (inclusive)
    (for ([i (in-range 1 (- (+ n 1) len))])
      (define j (+ i len -1)) ; Calculate the end point of the interval (j)
      (define current-min-cost +inf.0) ; Initialize with positive infinity

      ;; Iterate over all possible first guesses (k) within the interval [i, j]
      (for ([k (in-range i (+ j 1))])
        ;; The cost for picking k as the first guess is k plus the maximum
        ;; of the costs for the two subproblems (left and right).
        ;; We take the max because we need to guarantee a win in the worst case.
        (define cost-if-k-is-first-guess
          (+ k
             (max (if (<= i (- k 1)) (vector-ref (vector-ref dp i) (- k 1)) 0) ; Cost for [i, k-1]
                  (if (<= (+ k 1) j) (vector-ref (vector-ref dp (+ k 1)) j) 0)))) ; Cost for [k+1, j]

        ;; Update the minimum cost for the current interval [i, j]
        (set! current-min-cost (min current-min-cost cost-if-k-is-first-guess)))

      ;; Store the calculated minimum cost in the DP table
      (vector-set! (vector-ref dp i) j current-min-cost)))

  ;; The result is the minimum cost for the full range [1, n]
  (vector-ref (vector-ref dp 1) n))