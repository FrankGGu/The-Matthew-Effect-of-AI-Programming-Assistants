(define (find-x-sum-of-all-k-long-subarrays-i nums k)
  (let* ((n (length nums)))
    (if (or (> k n) (< k 1))
        0
        (let ((initial-window (take nums k)))
          (let loop ((current-list (drop nums k))
                     (current-window-head nums)
                     (current-window-sum (apply + initial-window))
                     (total-sum-of-window-sums (apply + initial-window)))
            (if (empty? current-list)
                total-sum-of-window-sums
                (let* ((new-element (car current-list))
                       (old-element (car current-window-head))
                       (next-window-sum (+ (- current-window-sum old-element) new-element)))
                  (loop (cdr current-list)
                        (cdr current-window-head)
                        next-window-sum
                        (+ total-sum-of-window-sums next-window-sum)))))))))