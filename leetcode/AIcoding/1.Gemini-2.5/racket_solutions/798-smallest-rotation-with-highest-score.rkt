(define (best-rotation nums)
  (let* ((n (vector-length nums))
         (delta (make-vector n 0))
         (initial-score 0))

    ;; Populate the delta array and calculate the initial score for k=0
    (for ([i (in-range n)])
      (let ((num-i (vector-ref nums i)))

        ;; Calculate initial score for k=0
        (when (<= num-i i)
          (set! initial-score (+ initial-score 1)))

        ;; Calculate k_stop: the rotation k where nums[i] (at original index i)
        ;; moves to index num-i - 1, thus stopping to contribute a point.
        ;; The new index is (i - k + n) % n.
        ;; We want (i - k + n) % n = num-i - 1.
        ;; k = (i - (num-i - 1) + n) % n = (i - num-i + 1 + n) % n.
        (let ((k-stop (modulo (+ i (- num-i) 1 n) n)))
          (vector-set! delta k-stop (- (vector-ref delta k-stop) 1)))

        ;; Calculate k_start: the rotation k where nums[i] (at original index i)
        ;; moves to index n - 1, thus starting to contribute a point again
        ;; (after wrapping around from index 0).
        ;; We want (i - k + n) % n = n - 1.
        ;; k = (i - (n - 1) + n) % n = (i + 1 + n) % n.
        (let ((k-start (modulo (+ i 1 n) n)))
          (vector-set! delta k-start (+ (vector-ref delta k-start) 1)))))

    ;; Iterate through possible rotations k from 1 to n-1
    ;; to find the maximum score and the smallest k that achieves it.
    (let loop ((k 1)
               (current-score initial-score)
               (max-score initial-score)
               (best-k 0))
      (if (>= k n)
          best-k
          (let* ((new-current-score (+ current-score (vector-ref delta k)))
                 (new-max-score (if (> new-current-score max-score) new-current-score max-score))
                 (new-best-k (if (> new-current-score max-score) k best-k)))
            (loop (+ k 1) new-current-score new-max-score new-best-k))))))