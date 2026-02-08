(define (longest-nice-subarray nums)
  (let* ([n (vector-length nums)]
         [max-len 0]
         [left 0]
         [current-or-val 0])
    (for ([right (in-range n)])
      (let ([num_r (vector-ref nums right)])
        ;; While num_r shares any set bit with elements currently in the window [left, right-1]
        ;; (i.e., current-or-val), shrink the window from the left.
        (let loop ()
          (when (not (zero? (bitwise-and current-or-val num_r)))
            ;; Remove nums[left] from current-or-val.
            ;; This works because all elements in the window are pairwise bit-disjoint,
            ;; so OR is equivalent to XOR for elements in the window.
            (set! current-or-val (bitwise-xor current-or-val (vector-ref nums left)))
            (set! left (+ left 1))
            (loop)))

        ;; Add num_r to the window and update current-or-val.
        ;; Since (bitwise-and current-or-val num_r) is 0 at this point,
        ;; bitwise-ior is equivalent to bitwise-xor.
        (set! current-or-val (bitwise-ior current-or-val num_r))

        ;; Update max-len with the current window length.
        (set! max-len (max max-len (- right left -1))))) ; equivalent to right - left + 1
    max-len))