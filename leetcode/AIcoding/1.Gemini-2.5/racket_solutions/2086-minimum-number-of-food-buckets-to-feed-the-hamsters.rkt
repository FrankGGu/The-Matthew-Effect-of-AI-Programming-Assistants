(define (minimum-buckets hamsters)
  (define n (string-length hamsters))
  (define s (string->vector hamsters))
  (define buckets 0)

  (for ([i (in-range n)])
    (when (char=? (vector-ref s i) #\H)
      ;; Check if this hamster is already fed by a bucket to its left.
      ;; If s[i-1] is 'B', it means a bucket was placed there in a previous step.
      (unless (and (> i 0) (char=? (vector-ref s (- i 1)) #\B))
        ;; This hamster is not fed by its left. We need to place a new bucket.
        ;; Greedy strategy: try to place a bucket to its right first,
        ;; as it might feed this hamster and potentially the next one.
        (cond
          ;; Option 1: Place a bucket to the right if possible.
          [(and (< (+ i 1) n) (char=? (vector-ref s (+ i 1)) #\.))
           (vector-set! s (+ i 1) #\B) ; Mark the spot as a bucket
           (set! buckets (+ buckets 1))]
          ;; Option 2: If placing to the right is not possible (e.g., out of bounds, or next is 'H'),
          ;; try to place a bucket to its left.
          [(and (> i 0) (char=? (vector-ref s (- i 1)) #\.))
           (vector-set! s (- i 1) #\B) ; Mark the spot as a bucket
           (set! buckets (+ buckets 1))]
          ;; Option 3: Cannot place a bucket to the right or left.
          ;; This hamster cannot be fed, so it's impossible.
          [else
           (set! buckets -1) ; Indicate impossibility
           (break)])))) ; Exit the loop early as it's impossible

  buckets)