#lang racket

(define (max-frequency nums k)
  ;; Sort the array to enable the sliding window approach.
  ;; Convert list to vector for O(1) element access.
  (define sorted-nums (vector-sort < (list->vector nums)))
  (define n (vector-length sorted-nums))

  ;; Initialize sliding window pointers, sum, and maximum frequency.
  ;; `left-ptr`: left boundary of the window.
  ;; `current-sum-val`: sum of elements within the current window [left-ptr, right-ptr].
  ;; `max-freq-val`: stores the maximum frequency found so far.
  (let loop ((right-ptr 0)
             (left-ptr 0)
             (current-sum-val 0)
             (max-freq-val 0))
    ;; Base case: if right-ptr has exceeded array bounds, return the max frequency.
    (if (>= right-ptr n)
        max-freq-val
        (let* ((num-at-right (vector-ref sorted-nums right-ptr))
               (next-sum (+ current-sum-val num-at-right)))
          ;; Inner loop to shrink the window from the left if the current window
          ;; cannot be made valid with 'k' operations.
          (let loop-shrink ((l left-ptr)
                            (s next-sum))
            (let* ((window-length (- right-ptr l -1)) ; Calculate current window length (right - left + 1)
                   (target-val num-at-right)           ; The target value for all elements in the window
                   ;; Calculate the cost to make all elements in the window equal to target-val.
                   ;; Cost = (window_length * target_val) - sum_of_elements_in_window
                   (cost (- (* window-length target-val) s)))
              (if (<= cost k)
                  ;; If the cost is within k, the window is valid.
                  ;; Update max-freq-val and move the right pointer to expand the window.
                  (loop (+ right-ptr 1)
                        l
                        s
                        (max max-freq-val window-length))
                  ;; If the cost exceeds k, the window is invalid.
                  ;; Shrink the window from the left by moving 'l' and subtracting
                  ;; the element at 'l' from the sum. Then re-check the cost.
                  (loop-shrink (+ l 1)
                               (- s (vector-ref sorted-nums l))))))))))