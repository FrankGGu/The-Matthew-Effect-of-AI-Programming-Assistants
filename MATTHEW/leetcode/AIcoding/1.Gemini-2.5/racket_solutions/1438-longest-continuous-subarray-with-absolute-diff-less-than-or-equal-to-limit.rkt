#lang racket
(require data/deque)

(define (longest-subarray nums limit)
  (let* ((n (length nums))
         (min-deque (make-deque))
         (max-deque (make-deque))
         (left 0)
         (max-len 0))
    (for ([right (in-range n)])
      (let ((current-num (list-ref nums right)))
        ;; Maintain max-deque (indices of elements in decreasing order of their values)
        (while (and (not (deque-empty? max-deque))
                    (< (list-ref nums (deque-back max-deque)) current-num))
          (deque-pop-back! max-deque))
        (deque-push-back! max-deque right)

        ;; Maintain min-deque (indices of elements in increasing order of their values)
        (while (and (not (deque-empty? min-deque))
                    (> (list-ref nums (deque-back min-deque)) current-num))
          (deque-pop-back! min-deque))
        (deque-push-back! min-deque right)

        ;; Shrink window from left if condition violated
        (while (> (- (list-ref nums (deque-front max-deque))
                     (list-ref nums (deque-front min-deque)))
                  limit)
          (set! left (+ left 1))
          ;; Remove elements from front of deques that are outside the current window [left, right]
          (when (< (deque-front max-deque) left)
            (deque-pop-front! max-deque))
          (when (< (deque-front min-deque) left)
            (deque-pop-front! min-deque)))

        ;; Update max-len
        (set! max-len (max max-len (+ 1 (- right left))))))
    max-len))