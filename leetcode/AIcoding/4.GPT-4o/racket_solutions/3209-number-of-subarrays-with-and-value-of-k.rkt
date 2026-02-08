(define (numSubarraysWithBitwiseAND nums k)
  (define (count-subarrays starting-index)
    (let loop ((end starting-index) (count 0) (length 0))
      (if (>= end (length nums))
          count
          (let ((and-value (apply bitwise-and (sublist nums starting-index end))))
            (if (= and-value k)
                (loop (+ end 1) (+ count (+ length 1)) (+ length 1))
                (loop (+ end 1) count 0))))))
  (define (total-count)
    (let loop ((i 0) (total 0))
      (if (>= i (length nums))
          total
          (loop (+ i 1) (+ total (count-subarrays i))))))
  (total-count))

(numSubarraysWithBitwiseAND '(1 2 3) 2)