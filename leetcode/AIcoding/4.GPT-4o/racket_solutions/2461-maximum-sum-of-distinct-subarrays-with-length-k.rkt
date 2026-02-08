(define (maximumSum nums k)
  (define (helper start end)
    (if (>= end (length nums))
        0
        (let* ((subarray (sublist nums start end))
               (distinct-subarray (remove-duplicates subarray))
               (sum (apply + distinct-subarray)))
          (max sum (helper start (+ end 1)) (if (< end (+ start k)) (helper (+ start 1) (+ start k)) 0)))))
  (if (>= (length nums) k)
      (helper 0 k)
      0))

(maximumSum '(1 2 3 2 2) 3)