#lang racket

(define (minimum-cost source target original changed cost)
  (define n (string-length source))
  (define m (vector-length original))

  ;; A sufficiently large number to represent infinity.
  ;; Max possible cost is n * max_single_conversion_cost = 1000 * 10^9 = 10^12.
  ;; We use 10^15 to be safely larger.
  (define +inf (expt 10 15))

  ;; Step 1: Precompute direct conversion costs for all (original_str, changed_str) pairs.
  ;; Use a hash table where keys are (cons original-string changed-string) and values are minimum costs.
  (define direct-conversion-costs (make-hash))

  (for ([i (in-range m)])
    (define orig-str (vector-ref original i))
    (define chg-str (vector-ref changed i))
    (define c (vector-ref cost i))
    (define key (cons orig-str chg-str))
    (hash-set! direct-conversion-costs key
               (min c (hash-ref direct-conversion-costs key +inf))))

  ;; Step 2: Dynamic Programming
  ;; dp[i] represents the minimum cost to convert the prefix source[0...i-1] to target[0...i-1].
  ;; The dp array has size n+1, where dp[0] is the base case (cost for empty prefix).
  (define dp (make-vector (+ n 1) +inf))
  (vector-set! dp 0 0) ; Cost to convert empty string to empty string is 0.

  (for ([i (in-range 1 (+ n 1))])
    ;; Option 1: If source[i-1] is the same as target[i-1], we can convert it with 0 cost.
    ;; This means we just extend the conversion from dp[i-1].
    (when (char=? (string-ref source (- i 1)) (string-ref target (- i 1)))
      (when (!= (vector-ref dp (- i 1)) +inf) ; Only consider if the previous state is reachable
        (vector-set! dp i (min (vector-ref dp i) (vector-ref dp (- i 1))))))

    ;; Option 2: Apply a substring conversion rule ending at index i-1.
    ;; The length of original/changed strings is at most 10.
    ;; So we only need to look back up to 10 characters.
    (for ([len (in-range 1 11)]) ; Substring length from 1 to 10
      (define k (- i len)) ; Starting index of the substring in source/target
      (when (>= k 0) ; Ensure k is a valid index
        (when (!= (vector-ref dp k) +inf) ; Only consider if the state dp[k] is reachable
          (define sub-s (substring source k i)) ; Substring from source
          (define sub-t (substring target k i)) ; Substring from target
          (define key (cons sub-s sub-t))
          (define conversion-cost (hash-ref direct-conversion-costs key +inf))

          ;; If a direct conversion rule exists for sub-s to sub-t
          (when (!= conversion-cost +inf)
            (vector-set! dp i (min (vector-ref dp i)
                                   (+ (vector-ref dp k) conversion-cost))))))))

  ;; The final answer is dp[n]. If it's still +inf, it means conversion is impossible.
  (if (= (vector-ref dp n) +inf)
      -1
      (vector-ref dp n)))