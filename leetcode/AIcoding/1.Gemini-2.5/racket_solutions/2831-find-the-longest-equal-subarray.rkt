(define (longest-equal-subarray nums k)
  (define n (vector-length nums))
  (define counts (make-hash)) ; Stores frequency of each number in the current window
  (define left 0)
  (define max-len 0)
  (define max-freq-in-window 0) ; Maximum frequency of any single element in the current window

  (for ([right (in-range n)])
    (define current-num (vector-ref nums right))

    ; Add the current number to the window and update its count
    (hash-set! counts current-num (+ (hash-ref counts current-num 0) 1))

    ; Update max-freq-in-window
    ; This variable tracks the highest frequency of any element encountered so far
    ; in any valid window. It only ever increases or stays the same.
    (set! max-freq-in-window (max max-freq-in-window (hash-ref counts current-num 0)))

    ; Shrink the window from the left if the condition is violated:
    ; (current_window_size - max_freq_of_any_element) > k
    ; This means we have more than k elements that are not the most frequent one.
    (let loop ()
      (when (> (- (+ (- right left) 1) max-freq-in-window) k)
        (define left-num (vector-ref nums left))
        ; Decrement count of the number leaving the window
        (hash-set! counts left-num (- (hash-ref counts left-num) 1))
        ; Move the left pointer
        (set! left (+ left 1))
        ; Continue shrinking if the condition is still violated
        (loop)))

    ; After shrinking (if necessary), the current window [left, right] is valid.
    ; The length of the longest equal subarray we can form within this window
    ; is determined by max-freq-in-window.
    (set! max-len (max max-len max-freq-in-window)))

  max-len)