(define (stoneGameIII stones)
  (define n (length stones))
  (define stone-vec (list->vector stones))

  ; dp[i] represents the maximum score Alice can get more than Bob
  ; from the subarray stones[i:]
  ; Initialize dp vector with 0s. dp[n] will correctly be 0.
  (define dp (make-vector (+ n 1) 0))

  ; Iterate from n-1 down to 0 to fill the DP table
  (for ([i (range (- n 1) -1 -1)])
    (let* ([s0 (vector-ref stone-vec i)]
           ; Option 1: Alice takes 1 stone
           ; Her score increases by s0. The remaining game is from i+1.
           ; From i+1, Bob plays optimally, resulting in dp[i+1] (Alice's score - Bob's score).
           ; So, Alice's net gain from this move is s0 - dp[i+1].
           [score-if-take-1 (+ s0 (- (vector-ref dp (+ i 1))))]

           ; Option 2: Alice takes 2 stones
           ; Only possible if there are at least 2 stones remaining.
           ; Her score increases by s0 + s1. The remaining game is from i+2.
           ; Alice's net gain: (s0 + s1) - dp[i+2].
           [score-if-take-2 (if (< (+ i 1) n)
                                (+ s0
                                   (vector-ref stone-vec (+ i 1))
                                   (- (vector-ref dp (+ i 2))))
                                (- +inf.0))] ; Not enough stones, so this option is invalid (very low score)

           ; Option 3: Alice takes 3 stones
           ; Only possible if there are at least 3 stones remaining.
           ; Her score increases by s0 + s1 + s2. The remaining game is from i+3.
           ; Alice's net gain: (s0 + s1 + s2) - dp[i+3].
           [score-if-take-3 (if (< (+ i 2) n)
                                (+ s0
                                   (vector-ref stone-vec (+ i 1))
                                   (vector-ref stone-vec (+ i 2))
                                   (- (vector-ref dp (+ i 3))))
                                (- +inf.0))]) ; Not enough stones, so this option is invalid (very low score)

      ; Alice chooses the option that maximizes her net gain
      (vector-set! dp i (max score-if-take-1 score-if-take-2 score-if-take-3))))

  ; The final score is dp[0], representing Alice's total score minus Bob's total score
  (define final-score (vector-ref dp 0))

  ; Determine the winner based on the final score
  (cond
    [(> final-score 0) "Alice"]
    [(< final-score 0) "Bob"]
    [else "Tie"]))