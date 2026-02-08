#lang racket

(define (min-sideway-jumps obstacles)
  (define n (vector-length obstacles))
  (define +inf (expt 10 9)) ; A large integer for infinity

  ; dp[j] stores the minimum jumps to reach the current point in lane j.
  ; Lanes are 1-indexed (1, 2, 3), so the dp vector will have size 4.
  ; dp[0] is unused.
  ; Initial state at point 0:
  ; Frog starts in lane 2 (0 jumps).
  ; To be in lane 1 or 3 at point 0, it requires 1 jump from lane 2.
  (define dp (vector +inf 1 0 1)) ; dp[1], dp[2], dp[3]

  (for ([i (in-range 1 n)])
    (define current-obstacle (vector-ref obstacles i))
    (define new-dp (vector +inf +inf +inf +inf))

    ; Step 1: Calculate cost to reach current point i by moving forward
    ; If there's no obstacle in lane j at point i, the frog can move forward
    ; from point i-1 in lane j to point i in lane j with the same number of jumps.
    (for ([j (in-range 1 4)]) ; Iterate through lanes 1, 2, 3
      (unless (= current-obstacle j) ; If no obstacle in lane j
        (vector-set! new-dp j (vector-ref dp j))))

    ; Step 2: Apply sideway jumps at current point i
    ; The frog can jump between lanes at the same point i if there's no obstacle
    ; in the target lane at i. This means new-dp[j] can be updated from new-dp[k] + 1.
    ; Since a jump can be from any lane to any other lane, and updates propagate,
    ; we need to iterate over this step multiple times (e.g., 2 times for 3 lanes)
    ; to ensure all minimums are correctly propagated.
    (for ([_ (in-range 2)]) ; Two passes for sideway jump propagation
      (for ([j (in-range 1 4)]) ; Destination lane
        (unless (= current-obstacle j) ; If no obstacle in destination lane j
          (for ([k (in-range 1 4)]) ; Source lane for jump
            ; If k is a different lane than j, and there's no obstacle in lane k at point i
            (when (and (not (= j k)) (not (= current-obstacle k)))
              (vector-set! new-dp j
                           (min (vector-ref new-dp j)
                                (+ (vector-ref new-dp k) 1))))))))

    ; Update dp for the next iteration
    (set! dp new-dp))

  ; The minimum jumps to reach the end (point n-1) in any of the three lanes.
  (min (vector-ref dp 1) (vector-ref dp 2) (vector-ref dp 3)))