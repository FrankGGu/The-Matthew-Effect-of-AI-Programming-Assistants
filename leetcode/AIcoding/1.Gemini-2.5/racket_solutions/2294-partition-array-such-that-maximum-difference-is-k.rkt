(define (partition-array-such-that-maximum-difference-is-k nums k)
  (let ((sorted-nums (sort nums <)))
    (if (empty? sorted-nums)
        0
        (let loop ((remaining-nums sorted-nums)
                   (partitions 0))
          (if (empty? remaining-nums)
              partitions
              (let* ((current-min (car remaining-nums))
                     (next-partition-start (let find-end ((lst (cdr remaining-nums)))
                                             (if (or (empty? lst)
                                                     (> (- (car lst) current-min) k))
                                                 lst
                                                 (find-end (cdr lst))))))
                (loop next-partition-start (+ partitions 1))))))))