#lang racket

(define (max-score-jump nums k)
  (define n (vector-length nums))
  (define dp (make-vector n))

  (vector-set! dp 0 (vector-ref nums 0))

  (require racket/list) ; For mutable-list

  ; Deque stores indices
  (define deque (mutable-list 0)) ; Initialize with index 0

  (for ([i (in-range 1 n)])
    ; Remove indices from the front of the deque that are out of the window [i - k, i - 1]
    (when (and (not (mutable-list-empty? deque))
               (< (mutable-list-first deque) (- i k)))
      (mutable-list-remove-front! deque))

    ; The maximum value in the current window is dp[deque.first()]
    (define max-prev-dp (vector-ref dp (mutable-list-first deque)))
    (vector-set! dp i (+ (vector-ref nums i) max-prev-dp))

    ; Add i to the deque, maintaining decreasing order of dp values
    (let loop ()
      (when (and (not (mutable-list-empty? deque))
                 (<= (vector-ref dp (mutable-list-last deque)) (vector-ref dp i)))
        (mutable-list-remove-end! deque)
        (loop)))
    (mutable-list-add-end! deque i))

  (vector-ref dp (- n 1)))