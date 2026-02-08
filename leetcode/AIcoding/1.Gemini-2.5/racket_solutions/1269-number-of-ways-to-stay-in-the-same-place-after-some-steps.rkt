(define (num-ways steps arrLen)
  (define MOD 1000000007)

  ; The maximum position we need to consider in the DP table.
  ; We must return to index 0. If we move 'k' steps to the right,
  ; we must also move 'k' steps to the left to return to 0.
  ; This implies that the maximum index we can reach is 'k' where 2*k <= steps,
  ; so k <= steps / 2.
  ; Also, we cannot go beyond arrLen - 1.
  ; Therefore, the maximum index to track is min(arrLen - 1, floor(steps / 2)).
  (define max-pos-idx (min (- arrLen 1) (floor (/ steps 2))))

  ; dp[j] stores the number of ways to reach index j after 's' steps.
  ; We use two vectors to optimize space: 'dp' for (s-1) steps and 'next-dp' for 's' steps.
  (define dp (make-vector (+ max-pos-idx 1) 0))

  ; Base case: 1 way to be at index 0 after 0 steps.
  (vector-set! dp 0 1)

  ; Iterate through each step from 1 to 'steps'.
  (for ([s (in-range 1 (+ steps 1))])
    (define next-dp (make-vector (+ max-pos-idx 1) 0)) ; Initialize next-dp for current step 's'

    ; Iterate through all possible positions in the effective array length.
    (for ([pos (in-range (+ max-pos-idx 1))])
      (define current-ways 0)

      ; Ways to reach 'pos' by staying at 'pos' in the previous step (s-1).
      (set! current-ways (vector-ref dp pos))

      ; Ways to reach 'pos' by moving left from 'pos + 1' in the previous step (s-1).
      (when (< (+ pos 1) (vector-length dp)) ; Check if 'pos + 1' is within bounds
        (set! current-ways (modulo (+ current-ways (vector-ref dp (+ pos 1))) MOD)))

      ; Ways to reach 'pos' by moving right from 'pos - 1' in the previous step (s-1).
      (when (> pos 0) ; Check if 'pos - 1' is within bounds
        (set! current-ways (modulo (+ current-ways (vector-ref dp (- pos 1))) MOD)))

      (vector-set! next-dp pos current-ways))

    ; Update 'dp' to 'next-dp' for the next iteration.
    (set! dp next-dp))

  ; The final result is the number of ways to be at index 0 after 'steps' steps.
  (vector-ref dp 0))