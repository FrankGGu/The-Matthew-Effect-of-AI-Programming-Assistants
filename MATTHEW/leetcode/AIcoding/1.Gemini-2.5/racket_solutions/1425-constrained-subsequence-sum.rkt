#lang racket

(require data/deque)

(define (constrained-subsequence-sum nums k)
  (define n (vector-length nums))
  (define dp (make-vector n))
  (define dq (make-deque)) ; Stores indices of elements in the sliding window

  (define max-overall-sum -inf.0) ; Initialize with negative infinity

  (for ([i (in-range n)])
    ;; 1. Remove indices from the front of the deque that are outside the current window [i-k, i-1]
    (when (and (not (deque-empty? dq))
               (< (deque-front dq) (- i k)))
      (deque-pop-front! dq))

    (define current-num (vector-ref nums i))

    ;; 2. Get the maximum dp value from the current window (which is at the front of the deque)
    (define prev-max-dp-val
      (if (deque-empty? dq)
          0 ; If deque is empty, no previous elements in window, so start a new subsequence
          (vector-ref dp (deque-front dq))))

    ;; 3. Calculate dp[i]: current_dp = nums[i] + max(0, max_dp_in_window)
    (define current-dp
      (+ current-num (if (> prev-max-dp-val 0) prev-max-dp-val 0)))

    (vector-set! dp i current-dp)

    ;; 4. Update the overall maximum sum found so far
    (set! max-overall-sum (max max-overall-sum current-dp))

    ;; 5. Remove indices from the back of the deque whose dp values are less than or equal to current-dp
    ;;    This maintains the decreasing order property of dp values in the deque, ensuring the front
    ;;    always holds the maximum.
    (let loop ()
      (when (and (not (deque-empty? dq))
                 (<= (vector-ref dp (deque-back dq)) current-dp))
        (deque-pop-back! dq)
        (loop)))

    ;; 6. Add the current index to the back of the deque
    (deque-push-back! dq i))

  max-overall-sum)