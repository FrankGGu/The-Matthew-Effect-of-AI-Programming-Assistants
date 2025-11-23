#lang racket

(define (reschedule-meetings-for-maximum-free-time-ii meetings)
  (cond
    [(empty? meetings) 0]
    [else
     (define sorted-meetings
       (sort meetings (lambda (a b) (< (first a) (first b)))))

     (define (merge-intervals intervals)
       (if (empty? intervals)
           '()
           (let loop ((current-merged (first intervals))
                      (remaining (rest intervals))
                      (acc '()))
             (if (empty? remaining)
                 (reverse (cons current-merged acc))
                 (let* ((next (first remaining))
                        (current-start (first current-merged))
                        (current-end (second current-merged))
                        (next-start (first next))
                        (next-end (second next)))
                   (if (<= next-start current-end)
                       (loop (list current-start (max current-end next-end))
                             (rest remaining)
                             acc)
                       (loop next
                             (rest remaining)
                             (cons current-merged acc))))))))

     (define merged-intervals (merge-intervals sorted-meetings))

     (define (calculate-free-time merged)
       (if (<= (length merged) 1)
           0
           (let loop ((total-free 0)
                      (prev-end (second (first merged)))
                      (remaining (rest merged)))
             (if (empty? remaining)
                 total-free
                 (let* ((current-interval (first remaining))
                        (current-start (first current-interval)))
                   (loop (+ total-free (- current-start prev-end))
                         (second current-interval)
                         (rest remaining)))))))

     (calculate-free-time merged-intervals)]))