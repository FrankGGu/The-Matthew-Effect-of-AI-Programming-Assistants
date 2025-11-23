(define (first-day-where-you-have-been-in-all-the-rooms nextVisit)
  (let* ([n (length nextVisit)]
         [MOD 1000000007]
         [dp (make-vector n 0)]
         [nv-vec (list->vector nextVisit)])

    ;; dp[i] represents the number of days passed until we arrive at room i for the first time,
    ;; having previously visited room i-1 an even number of times.
    ;; At this point (day dp[i]), we are in room i and are about to move to (i+1)%n.

    ;; Base case: dp[0] = 0.
    ;; We start at room 0 on day 0. There is no room -1 to consider.
    (vector-set! dp 0 0)

    ;; Iterate for rooms i from 1 to n-1
    (for ([i (in-range 1 n)])
      (let* ([dp-i-minus-1 (vector-ref dp (- i 1))]
             [next-visit-room-for-i-minus-1 (vector-ref nv-vec (- i 1))]
             [dp-next-visit-room (vector-ref dp next-visit-room-for-i-minus-1)]
             ;; The recurrence relation is:
             ;; dp[i] = (2 * dp[i-1] - dp[nextVisit[i-1]] + 2) % MOD
             ;; This formula accounts for:
             ;; 1. Reaching room (i-1) for the first time, having visited (i-2) an even number of times (dp[i-1] days).
             ;; 2. Moving from (i-1) (odd visit) to nextVisit[i-1] (1 day).
             ;; 3. Traversing from nextVisit[i-1] back to (i-1) to make it an even visit.
             ;;    This takes (dp[i-1] - dp[nextVisit[i-1]]) days.
             ;; 4. Moving from (i-1) (even visit) to i (1 day).
             ;; Summing these: dp[i-1] + 1 + (dp[i-1] - dp[nextVisit[i-1]]) + 1
             ;;                = 2 * dp[i-1] - dp[nextVisit[i-1]] + 2
             [val (+ (* 2 dp-i-minus-1) (- 2 dp-next-visit-room))]
             [res (modulo val MOD)])
        (vector-set! dp i res)))

    ;; The final answer is dp[n-1].
    ;; This is the day we arrive at room n-1 for the first time,
    ;; having visited room n-2 an even number of times.
    ;; At this point, all rooms from 0 to n-1 have been visited at least once,
    ;; and all rooms from 0 to n-2 have been visited an even number of times.
    ;; Room n-1 has been visited once (odd). This fulfills the condition of visiting all rooms.
    (vector-ref dp (- n 1))))