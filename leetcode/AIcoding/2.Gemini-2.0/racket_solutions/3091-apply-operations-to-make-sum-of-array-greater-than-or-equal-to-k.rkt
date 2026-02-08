(define (apply-operations nums k)
  (let* ((n (length nums))
         (positive-sum (foldl + 0 (filter positive? nums)))
         (negative-nums (sort (filter negative? nums) >)))
    (if (>= positive-sum k)
        0
        (let loop ((i 0) (current-sum positive-sum))
          (cond
            ((>= current-sum k) i)
            ((= i (length negative-nums)) -1)
            (else (loop (+ i 1) (+ current-sum (abs (list-ref negative-nums i))))))))))