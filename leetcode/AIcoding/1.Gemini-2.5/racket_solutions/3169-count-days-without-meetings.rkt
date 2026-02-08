(define (count-days-without-meetings days meetings)
  (if (empty? meetings)
      days
      (let* ((sorted-meetings (sort meetings (lambda (m1 m2) (< (car m1) (car m2)))))
             (merged-intervals
              (let loop ((remaining (cdr sorted-meetings))
                         (current-merged (car sorted-meetings))
                         (acc '()))
                (if (empty? remaining)
                    (reverse (cons current-merged acc))
                    (let* ((next-meeting (car remaining))
                           (current-start (car current-merged))
                           (current-end (cadr current-merged))
                           (next-start (car next-meeting))
                           (next-end (cadr next-meeting)))
                      (if (<= next-start (+ current-end 1))
                          (loop (cdr remaining)
                                (list current-start (max current-end next-end))
                                acc)
                          (loop (cdr remaining)
                                next-meeting
                                (cons current-merged acc))))))))
        (let ((total-meeting-days
               (foldl (lambda (interval sum)
                        (+ sum (- (cadr interval) (car interval) -1)))
                      0
                      merged-intervals)))
          (- days total-meeting-days)))))