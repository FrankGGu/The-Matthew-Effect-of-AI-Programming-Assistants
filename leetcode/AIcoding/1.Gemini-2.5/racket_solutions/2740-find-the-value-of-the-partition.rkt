(define (find-value-of-partition nums)
  (let* ((sorted-nums (sort nums <))
         (diffs (map (lambda (a b) (abs (- b a)))
                     sorted-nums
                     (cdr sorted-nums))))
    (apply min diffs)))