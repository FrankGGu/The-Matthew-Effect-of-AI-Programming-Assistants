(define (greatest-sum-divisible-by-three nums)
  (define dp (vector 0 -1000000000 -1000000000)) ; dp[0]: max sum % 3 == 0, dp[1]: max sum % 3 == 1, dp[2]: max sum % 3 == 2

  (for-each (lambda (n)
              (define next-dp (vector-copy dp)) ; Create a copy for the next state

              (for ([i (in-range 3)])
                (when (> (vector-ref dp i) -999999999) ; Check if dp[i] is a reachable sum (not -infinity)
                  (define current-sum (+ (vector-ref dp i) n))
                  (define remainder (modulo current-sum 3))
                  (vector-set! next-dp remainder (max (vector-ref next-dp remainder) current-sum))))
              (set! dp next-dp)) ; Update dp to the new state
            nums)

  (vector-ref dp 0)) ; The maximum sum divisible by 3 is stored in dp[0]