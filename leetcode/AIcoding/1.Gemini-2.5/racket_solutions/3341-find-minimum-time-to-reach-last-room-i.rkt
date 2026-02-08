#lang racket
(require data/deque)

(define (find-minimum-time-to-reach-last-room rooms k)
  (define n (vector-length rooms))

  ; A sufficiently large number representing infinity.
  ; Max possible time is n * max_room_time.
  ; Assuming rooms[i] >= 0.
  (define +infinity (add1 (* n (if (> n 0) (apply max 0 (vector->list rooms)) 0))))

  ; dp[i][j] = minimum time to clean room i, having used j skips in total
  ; Initialize dp table with +infinity
  (define dp (make-vector n))
  (for ([i (in-range n)])
    (vector-set! dp i (make-vector (add1 k) +infinity)))

  ; deques[d_idx] stores (value . skips_count) for dp[room_idx][skips_count]
  ; where room_idx - skips_count = d_idx - d_offset
  ; d_offset = k is used to map the difference (room_idx - skips_count)
  ; from its range [-k, n-1] to a non-negative index [0, n-1+k]
  (define d_offset k)
  (define deques (make-vector (+ n k)))
  (for ([i (in-range (+ n k))])
    (vector-set! deques i (make-deque)))

  ; Initialize dp[0][0] if n > 0
  (when (> n 0)
    (vector-set! (vector-ref dp 0) 0 (vector-ref rooms 0))

    ; Add dp[0][0] to its corresponding deque
    ; For dp[0][0], room_idx = 0, skips_count = 0.
    ; d = 0 - 0 = 0. d_idx = 0 + d_offset = k.
    (define d-0-0+k k)
    (when (and (>= d-0-0+k 0) (< d-0-0+k (+ n k)))
      (deque-push-back! (vector-ref deques d-0-0+k) (cons (vector-ref rooms 0) 0))))

  ; Add the virtual dp[-1][0] = 0 to its deque.
  ; This represents the state before room 0, with 0 time and 0 skips.
  ; It allows paths that start by skipping rooms (e.g., skip room 0 to reach room 1).
  ; For dp[-1][0], room_idx = -1, skips_count = 0.
  ; d = -1 - 0 = -1. d_idx = -1 + d_offset = k - 1.
  (define d-minus-1+k (- k 1))
  (when (and (>= d-minus-1+k 0) (< d-minus-1+k (+ n k)))
    (deque-push-back! (vector-ref deques d-minus-1+k) (cons 0 0)))

  ; Iterate through rooms starting from room 1 (room 0 handled by initialization)
  (for ([i (in-range 1 n)]) ; current room index
    (for ([j (in-range (add1 k))]) ; number of skips
      (define current-min-prev-state +infinity)

      ; Calculate d_idx for the diagonal of previous states
      ; The terms in the min are dp[room_idx][skips_count] where room_idx - skips_count = i-j-1.
      ; So, d_target = (i-j-1) + d_offset.
      (define d-target (+ (- i j 1) d_offset))

      (when (and (>= d-target 0) (< d-target (+ n k)))
        (define current-deque (vector-ref deques d-target))

        ; Remove elements from the front of the deque that are too old.
        ; An element (val . skips_count) in deques[d_target] corresponds to
        ; dp[room_idx][skips_count] where room_idx = d_target - d_offset + skips_count.
        ; We need room_idx >= -1.
        ; So, d_target - d_offset + skips_count >= -1
        ; (i-j-1) + skips_count >= -1
        ; skips_count >= j-i.
        ; Also, skips_count must be non-negative. So, skips_count >= max(0, j-i).
        (define min-valid-skips (max 0 (- j i)))
        (while (and (not (deque-empty? current-deque))
                    (< (cdr (deque-front current-deque)) min-valid-skips))
          (deque-pop-front! current-deque))

        (when (not (deque-empty? current-deque))
          (set! current-min-prev-state (car (deque-front current-deque)))))

      ; If a valid previous state was found, update dp[i][j]
      (when (not (= current-min-prev-state +infinity))
        (vector-set! (vector-ref dp i) j (+ current-min-prev-state (vector-ref rooms i))))

      ; Add the newly computed dp[i][j] to its corresponding deque
      ; For dp[i][j], room_idx = i, skips_count = j.
      ; d = i - j. d_idx = (i-j) + d_offset.
      (when (not (= (vector-ref (vector-ref dp i) j) +infinity))
        (define d-current (+ (- i j) d_offset))
        (define current-deque (vector-ref deques d-current))
        ; Maintain monotonicity: remove elements from back that are greater than or equal to new value
        (while (and (not (deque-empty? current-deque))
                    (>= (car (deque-back current-deque)) (vector-ref (vector-ref dp i) j)))
          (deque-pop-back! current-deque))
        (deque-push-back! current-deque (cons (vector-ref (vector-ref dp i) j) j))))

  ; The final answer is the minimum time to reach room n-1 with any valid number of skips (0 to k)
  (define min-total-time +infinity)
  (when (> n 0) ; Only if there's at least one room
    (for ([j (in-range (add1 k))])
      (set! min-total-time (min min-total-time (vector-ref (vector-ref dp (- n 1)) j)))))

  min-total-time)