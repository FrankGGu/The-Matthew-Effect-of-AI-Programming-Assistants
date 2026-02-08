#lang racket

(define (find-max-form strs m n)
  ;; Create a 2D DP table initialized to zeros
  ;; dp[i][j] will store the maximum number of strings that can be formed
  ;; using at most i zeros and j ones.
  (define dp (make-vector (add1 m)))
  (for ([i (in-range (add1 m))])
    (vector-set! dp i (make-vector (add1 n) 0)))

  ;; Helper function to count zeros and ones in a string
  (define (count-zeros-ones s)
    (define zeros 0)
    (define ones 0)
    (for ([char (in-string s)])
      (if (char=? char #\0)
          (set! zeros (add1 zeros))
          (set! ones (add1 ones))))
    (values zeros ones))

  ;; Iterate through each string in the input list
  (for ([s strs])
    ;; Get the count of zeros and ones for the current string
    (define-values (zeros ones) (count-zeros-ones s))

    ;; Update the DP table. We iterate backwards to ensure that
    ;; each string is considered at most once for the current DP state.
    ;; This is a standard technique for 0/1 knapsack-like problems.
    (for ([i (in-range m (sub1 zeros) -1)]) ; Iterate 'm' (max zeros) down to 'zeros'
      (for ([j (in-range n (sub1 ones) -1)]) ; Iterate 'n' (max ones) down to 'ones'
        ;; dp[i][j] can either remain its current value (if we don't include the string 's')
        ;; or be updated by including string 's'.
        ;; If we include 's', we use 'zeros' number of zeros and 'ones' number of ones,
        ;; and add 1 to the count of strings from the previous state (dp[i-zeros][j-ones]).
        (define current-dp-val (vector-ref (vector-ref dp i) j))
        (define prev-dp-val (vector-ref (vector-ref dp (- i zeros)) (- j ones)))
        (vector-set! (vector-ref dp i) j (max current-dp-val (add1 prev-dp-val))))))

  ;; The final result is the maximum number of strings that can be formed
  ;; using at most 'm' zeros and 'n' ones.
  (vector-ref (vector-ref dp m) n))