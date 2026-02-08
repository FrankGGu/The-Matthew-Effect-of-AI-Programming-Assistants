(define (count-partitions nums target)
  (let* ((n (length nums))
         (total-sum (apply + nums))
         (half (+ target (/ total-sum 2))))
    (if (< half 0) 
        0
        (let loop ((i 0) (dp (make-vector (+ half 1) 0)))
          (if (>= i n)
              (vector-ref dp half)
              (begin
                (vector-set! dp 0 1)
                (for* ((j (in-range 1 (+ half 1))) 
                        (k (in-list nums)))
                  (vector-set! dp j 
                    (+ (vector-ref dp j) 
                       (if (>= j k) 
                           (vector-ref dp (- j k)) 
                           0))))
                (loop (+ i 1) dp)))))))

(define (count-partitions-with-even-sum-diff nums)
  (count-partitions nums 0))

(count-partitions-with-even-sum-diff '(1 2 3 4 5))