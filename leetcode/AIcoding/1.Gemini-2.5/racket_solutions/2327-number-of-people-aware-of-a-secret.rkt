(define (people-aware n delay forget)
  (define MOD 1000000007)

  ; dp[i] = number of people who learn the secret on day i
  (define dp (make-vector (+ n 1) 0)) 
  ; prefix-sum[i] = sum of dp[k] for k from 1 to i
  (define prefix-sum (make-vector (+ n 1) 0))

  ; On day 1, one person learns the secret
  (vector-set! dp 1 1)
  (vector-set! prefix-sum 1 1)

  (for ([i (in-range 2 (+ n 1))])
    ; Calculate dp[i]: number of new people learning on day i
    ; These are people who are sharing on day i.
    ; A person who learned on day j is sharing on day i if:
    ; 1. j + delay <= i  (they have started sharing)  =>  j <= i - delay
    ; 2. j + forget > i  (they have not forgotten yet) =>  j >= i - forget + 1
    ; So, dp[i] is the sum of dp[k] for k from max(1, i - forget + 1) to i - delay

    (define start-idx (max 1 (+ i (- forget) 1)))
    (define end-idx (- i delay))

    (if (>= end-idx start-idx)
        ; The range of sharers is valid, calculate sum using prefix sums
        (let* ([sum-up-to-end (vector-ref prefix-sum end-idx)]
               [sum-before-start (vector-ref prefix-sum (max 0 (- start-idx 1)))]
               [new-learners (modulo (- sum-up-to-end sum-before-start) MOD)])
          (vector-set! dp i (modulo (+ new-learners MOD) MOD))) ; Ensure positive result
        ; The range is empty (e.g., delay >= forget), no one learns today
        (vector-set! dp i 0))

    ; Update prefix-sum for day i
    (vector-set! prefix-sum i (modulo (+ (vector-ref prefix-sum (- i 1)) (vector-ref dp i)) MOD)))

  ; The total number of people aware of the secret on day n is the sum of dp[j]
  ; for j such that j + forget > n (i.e., j >= n - forget + 1)
  ; This is the sum of dp[j] for j from max(1, n - forget + 1) to n
  (define final-start-idx (max 1 (+ n (- forget) 1)))
  (define final-sum-up-to-n (vector-ref prefix-sum n))
  (define final-sum-before-start (vector-ref prefix-sum (max 0 (- final-start-idx 1))))

  (modulo (+ (- final-sum-up-to-n final-sum-before-start) MOD) MOD))