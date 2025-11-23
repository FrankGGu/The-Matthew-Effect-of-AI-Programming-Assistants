(define (minimizeMaximumPairSum array)
  (define (helper array acc)
    (if (null? array)
        acc
        (let ((max-sum (+ (car array) (last array))))
          (helper (cdr (drop-right array 1)) (max acc max-sum)))))

  (let ((sorted-array (sort array <)))
    (helper sorted-array 0)))