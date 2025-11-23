#lang racket

(define (maximum-value-of-k-coins-from-piles piles k)
  (define n (length piles))

  ;; Precompute prefix sums for each pile.
  ;; For efficiency, store each pile's prefix sums as a vector.
  ;; The outer structure (pile-prefix-sums itself) is also a vector
  ;; to allow O(1) access to each pile's precomputed sums.
  (define pile-prefix-sums
    (build-vector n
                  (lambda (idx)
                    (let ((pile (list-ref piles idx))) ; Get the original pile list
                      (let loop ((coins pile) (current-sum 0) (acc '()))
                        (if (empty? coins)
                            (list->vector (reverse acc)) ; Convert accumulated sums to a vector
                            (let ((new-sum (+ current-sum (car coins))))
                              (loop (cdr coins) new-sum (cons new-sum acc)))))))))

  ;; dp is a 1D vector representing the maximum value for a given number of coins
  ;; considering all piles processed so far.
  ;; dp[j] stores the maximum value obtainable using exactly j coins.
  ;; Initialize with zeros, as 0 coins yield 0 value.
  (define dp (build-vector (+ k 1) (lambda (__) 0)))

  ;; Iterate through each pile
  (for ((current-pile-idx (in-range n))) ; current-pile-idx is 0-indexed
    (define current-pile-ps (vector-ref pile-prefix-sums current-pile-idx)) ; O(1) access to prefix sums vector
    (define current-pile-length (vector-length current-pile-ps)) ; O(1) access to pile length

    ;; Create a new dp vector to store results for the current pile.
    ;; This allows using the 'dp' vector (from previous piles) for calculations.
    (define new-dp (build-vector (+ k 1) (lambda (__) 0)))

    ;; Initialize new-dp with values from dp (representing not picking any coin from current pile)
    (for ((j (in-range (+ k 1))))
      (vector-set! new-dp j (vector-ref dp j)))

    ;; Iterate through the number of coins 'j' from k down to 0.
    ;; Iterating backwards ensures that when we access dp[j-x], we are using
    ;; the value from the *previous* pile's state, not the current pile's state
    ;; (which would be the case if we iterated forwards and updated dp in-place).
    ;; For this specific DP state transition (dp[i][j] depends on dp[i-1][j] and dp[i-1][j-x]),
    ;; an explicit `new-dp` vector makes the forward iteration safe and clear.
    ;; The backward iteration optimization is for when `dp[i][j]` depends on `dp[i][j-x]`.
    ;; Here, `new-dp[j]` depends on `dp[j-x]`, so forward iteration is fine with `new-dp`.
    (for ((j (in-range 0 (+ k 1))))
      ;; Consider picking 'x' coins from the current pile
      (for ((x (in-range 1 (+ current-pile-length 1)))) ; x is number of coins to pick from current pile
        (when (<= x j) ; Ensure we have enough coin budget 'j' to pick 'x' coins
          (define value-from-current-pile (vector-ref current-pile-ps (- x 1))) ; O(1) access
          (define prev-dp-value (vector-ref dp (- j x))) ; Value from previous piles with remaining budget
          (vector-set! new-dp j
                       (max (vector-ref new-dp j) ; Current max for new-dp[j]
                            (+ prev-dp-value value-from-current-pile))))))

    ;; Update the 'dp' vector for the next iteration (next pile)
    (set! dp new-dp))

  ;; The final answer is the maximum value obtainable using exactly k coins from all piles
  (vector-ref dp k))