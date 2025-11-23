#lang racket
(require data/deque)

(define (maximum-robots chargeTimes runningCosts budget)
  (define n (vector-length chargeTimes))
  (define left 0)
  (define current-sum-running-costs 0)
  (define max-robots 0)
  (define dq (make-deque)) ; Stores indices of chargeTimes, maintaining a decreasing order of values

  (for ([right (in-range n)])
    ;; 1. Expand window to the right
    (set! current-sum-running-costs (+ current-sum-running-costs (vector-ref runningCosts right)))

    ;; Maintain deque for maximum chargeTime in the current window.
    ;; Elements are stored as indices, and the values at these indices in chargeTimes
    ;; are in decreasing order from front to back of the deque.
    (let loop-remove-smaller-from-back ()
      (when (and (not (deque-empty? dq))
                 (<= (vector-ref chargeTimes (deque-back dq)) (vector-ref chargeTimes right)))
        (deque-pop-back! dq)
        (loop-remove-smaller-from-back)))
    (deque-push-back! dq right)

    ;; 2. Shrink window from the left if the current cost exceeds the budget
    (let loop-shrink-window ()
      (when (not (deque-empty? dq)) ; Only proceed if there are elements to form a window
        (let* ([current-max-charge-time (vector-ref chargeTimes (deque-front dq))]
               [current-window-length (+ (- right left) 1)]
               [current-cost (+ current-max-charge-time (* current-sum-running-costs current-window-length))])
          (when (> current-cost budget)
            ;; Shrink window from the left
            (set! current-sum-running-costs (- current-sum-running-costs (vector-ref runningCosts left)))

            ;; If the element being removed from the left is the maximum in the current window,
            ;; remove it from the front of the deque.
            (when (= (deque-front dq) left)
              (deque-pop-front! dq))

            (set! left (+ left 1))

            ;; Recalculate cost with the new, smaller window and potentially shrink again
            (loop-shrink-window)))))

    ;; 3. After potential shrinking, the window [left, right] is valid.
    ;; Update the maximum number of robots found so far.
    (set! max-robots (max max-robots (+ (- right left) 1))))

  max-robots)