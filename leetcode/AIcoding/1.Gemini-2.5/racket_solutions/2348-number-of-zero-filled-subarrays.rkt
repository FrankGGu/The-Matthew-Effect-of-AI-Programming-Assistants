(define (zero-filled-subarrays nums)
  (let loop ((nums nums)
             (total-subarrays 0)
             (current-zero-streak 0))
    (cond
      ((empty? nums)
       (+ total-subarrays
          (/ (* current-zero-streak (+ current-zero-streak 1)) 2)))
      (else
       (let ((num (first nums)))
         (if (= num 0)
             (loop (rest nums)
                   total-subarrays
                   (+ current-zero-streak 1))
             (loop (rest nums)
                   (+ total-subarrays
                      (/ (* current-zero-streak (+ current-zero-streak 1)) 2))
                   0)))))))