#lang racket
(require data/deque)

(define (max-score-reach-end-of-array-with-max-score nums k)
  (define n (length nums))
  (define nums-vec (list->vector nums))
  (define dp (make-vector n 0))

  (vector-set! dp 0 (vector-ref nums-vec 0))

  (define dq (make-deque))

  (deque-push-back! dq 0) ; Add index 0 to deque

  (for ([i (in-range 1 n)])
    ; Remove indices from front that are out of window [i - k, i - 1]
    (when (> (- i k) (deque-peek-front dq))
      (deque-pop-front! dq))

    ; Calculate dp[i] as current number + max score from previous reachable positions
    (vector-set! dp i (+ (vector-ref nums-vec i) (vector-ref dp (deque-peek-front dq))))

    ; Remove indices from back if their dp value is less than or equal to dp[i]
    ; This maintains the deque with indices in decreasing order of their dp values
    (let loop ()
      (when (and (not (deque-empty? dq))
                 (<= (vector-ref dp (deque-peek-back dq)) (vector-ref dp i)))
        (deque-pop-back! dq)
        (loop)))

    ; Add current index to back of deque
    (deque-push-back! dq i))

  ; The maximum score to reach the last index
  (vector-ref dp (- n 1)))