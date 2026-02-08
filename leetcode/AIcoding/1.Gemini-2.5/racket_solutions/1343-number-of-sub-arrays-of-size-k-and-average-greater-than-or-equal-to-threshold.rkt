(define (num-of-sub-arrays arr k threshold)
  (let* ((n (length arr))
         (target-sum (* k threshold))) ; Optimize comparison: sum >= k * threshold
    (if (< n k)
        0
        (let* ((initial-window (take arr k))
               (initial-sum (apply + initial-window)))
          (let loop ((remaining-arr (drop arr k)) ; Elements to be added to the window
                     (elements-to-remove arr) ; Elements to be removed from the window (head of this list)
                     (current-sum initial-sum)
                     (count (if (>= initial-sum target-sum) 1 0)))
            (if (null? remaining-arr)
                count
                (let* ((element-to-add (car remaining-arr))
                       (element-to-remove (car elements-to-remove))
                       (new-sum (+ (- current-sum element-to-remove) element-to-add)))
                  (loop (cdr remaining-arr)
                        (cdr elements-to-remove)
                        new-sum
                        (if (>= new-sum target-sum) (+ count 1) count)))))))))