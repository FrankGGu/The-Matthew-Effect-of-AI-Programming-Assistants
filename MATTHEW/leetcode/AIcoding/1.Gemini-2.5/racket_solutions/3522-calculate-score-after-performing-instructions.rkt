#lang racket

(require racket/list-queue)

(define (max-score-after-instructions nums k)
  (define n (vector-length nums))
  (define dp (make-vector n 0))
  (define dq (make-queue))

  ; Initialize dp[0] and the deque
  (vector-set! dp 0 (vector-ref nums 0))
  (queue-push-back! dq 0)

  (for ([i (in-range 1 n)])
    ; 1. Remove indices from the front of the deque that are too far
    ;    A valid previous index j for dp[i] must be in the range [max(0, i-k), i-1].
    ;    If the index at the front of the deque (queue-front dq) is less than i-k,
    ;    it is outside the valid window [i-k, i-1] and should be removed.
    (when (not (queue-empty? dq))
      (let loop ()
        (when (and (not (queue-empty? dq))
                   (< (queue-front dq) (- i k)))
          (queue-pop-front! dq)
          (loop))))

    ; 2. Calculate dp[i]
    ;    The front of the deque always holds the index j with the maximum dp[j]
    ;    within the current valid window.
    (vector-set! dp i (+ (vector-ref nums i) (vector-ref dp (queue-front dq))))

    ; 3. Maintain monotonic property of the deque
    ;    Remove indices from the back of the deque whose dp value is less than
    ;    or equal to the current dp[i]. These indices will never be the maximum
    ;    for future elements because current dp[i] is greater and has a larger index.
    (let ([current-dp-val (vector-ref dp i)])
      (let loop ()
        (when (and (not (queue-empty? dq))
                   (<= (vector-ref dp (queue-back dq)) current-dp-val))
          (queue-pop-back! dq)
          (loop))))

    ; 4. Add current index i to the back of the deque
    (queue-push-back! dq i))

  ; The problem asks for the maximum score to reach the last index (n-1).
  (vector-ref dp (- n 1)))