(define (minimum-time-to-finish-the-race n numLaps laps tires)
  (define +infinity+ (expt 10 15)) ; A sufficiently large number representing infinity.
                                  ; Max possible total time is ~2 * 10^14, so 10^15 is safe.

  ; min-time-for-k-consecutive-laps[k] stores the minimum time to complete k consecutive laps
  ; using a single tire, INCLUDING the change time for that tire.
  ; For k=0, this value is not directly used in the DP state transitions, as dp[0] is 0.
  (define min-time-for-k-consecutive-laps (make-vector (+ numLaps 1) +infinity+))

  ; Precompute min-time-for-k-consecutive-laps for all possible k and all tires.
  ; This loop iterates through each tire.
  (for ([i (in-range n)])
    (let* ([lap-time-initial (list-ref laps i)]
           [change-time (list-ref (list-ref tires i) 0)]
           [multiply-factor (list-ref (list-ref tires i) 1)])
      ; For each tire, calculate cumulative time for k consecutive laps (k=1, 2, ...)
      ; and update min-time-for-k-consecutive-laps.
      (let loop ([k 1] ; Current number of consecutive laps with this tire
                 [current-lap-time lap-time-initial] ; Time for the k-th lap
                 [cumulative-time-for-tire-without-change 0]) ; Sum of lap times for this tire, excluding change time
        ; Stop if k exceeds numLaps or if current-lap-time becomes too large to be useful.
        ; If a single lap takes more than +infinity+, it's not optimal.
        (when (and (<= k numLaps)
                   (<= current-lap-time +infinity+))
          (set! cumulative-time-for-tire-without-change (+ cumulative-time-for-tire-without-change current-lap-time))
          (let ([total-time-with-change (+ change-time cumulative-time-for-tire-without-change)])
            ; Update min-time-for-k-consecutive-laps[k] if this tire offers a better time
            (when (< total-time-with-change (vector-ref min-time-for-k-consecutive-laps k))
              (vector-set! min-time-for-k-consecutive-laps k total-time-with-change)))

          ; Prepare for the next lap (k+1)
          (when (> multiply-factor 1) ; Only multiply if factor > 1 to avoid infinite loop or large numbers when factor is 1
            (set! current-lap-time (* current-lap-time multiply-factor)))
          (loop (+ k 1) current-lap-time cumulative-time-for-tire-without-change)))))

  ; dp[i] stores the minimum time to finish i laps.
  (define dp (make-vector (+ numLaps 1) +infinity+))
  (vector-set! dp 0 0) ; 0 laps take 0 time.

  ; Dynamic programming to fill dp array
  (for ([i (in-range 1 (+ numLaps 1))])
    ; Iterate through possible number of laps (j) done with the *last* tire.
    ; The inner loop for j only needs to go up to a small constant (K_max)
    ; because min-time-for-k-consecutive-laps[j] will quickly become +infinity+
    ; for larger j due to the exponential growth of lap times.
    (let loop-j ([j 1])
      (when (<= j i)
        (let ([time-for-j-laps-with-new-tire (vector-ref min-time-for-k-consecutive-laps j)])
          (when (< time-for-j-laps-with-new-tire +infinity+) ; Only consider if j laps are possible with a single tire
            (let ([prev-laps (- i j)])
              (let ([current-total-time (+ (vector-ref dp prev-laps) time-for-j-laps-with-new-tire)])
                (when (< current-total-time (vector-ref dp i))
                  (vector-set! dp i current-total-time)))))
          ; If min-time-for-k-consecutive-laps[j] is infinity, it means no tire can complete
          ; j laps efficiently. Since lap times are positive, any j' > j will also be
          ; infinity or worse. So we can stop iterating j.
          (when (< time-for-j-laps-with-new-tire +infinity+)
            (loop-j (+ j 1)))))))

  (vector-ref dp numLaps))