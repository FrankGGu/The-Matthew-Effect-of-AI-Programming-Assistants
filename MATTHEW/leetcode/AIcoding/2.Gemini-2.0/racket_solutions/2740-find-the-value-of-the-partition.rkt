(define (findValueOfPartition nums)
  (let ((sorted-nums (sort nums <)))
    (let loop ((i 1) (min-diff +inf.0))
      (if (= i (length sorted-nums))
          min-diff
          (let ((diff (abs (- (list-ref sorted-nums i) (list-ref sorted-nums (- i 1))))))
            (loop (+ i 1) (min min-diff diff)))))))