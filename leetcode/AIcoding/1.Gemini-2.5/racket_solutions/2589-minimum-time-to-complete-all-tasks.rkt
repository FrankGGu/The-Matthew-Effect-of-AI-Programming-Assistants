#lang racket

(define (min-time-to-complete-all-tasks tasks)
  ;; Sort tasks primarily by their end times.
  ;; If end times are equal, sort by start times to ensure a consistent order,
  ;; though for this problem, the tie-breaking for equal end times doesn't significantly impact correctness
  ;; as long as end time is the primary sort key.
  (define sorted-tasks
    (sort tasks
          (lambda (t1 t2)
            (let ((e1 (cadr t1)) (e2 (cadr t2)))
              (if (= e1 e2)
                  (< (car t1) (car t2)) ; Tie-break by start time
                  (< e1 e2))))))        ; Primary sort by end time

  ;; `on-time` is a boolean vector where `(vector-ref on-time i)` is #t if time point `i` is 'on'.
  ;; Max time point is 2000, so vector size 2001 covers indices 0 to 2000.
  ;; Index 0 is unused.
  (define on-time (make-vector 2001 #f))

  ;; `total-on-time` tracks the total number of time points that are 'on'.
  (define total-on-time 0)

  ;; Iterate through each task in the sorted order.
  (for-each (lambda (task)
              (let* ((s (car task))  ; Start time
                     (e (cadr task)) ; End time
                     (d (caddr task))) ; Duration

                ;; Count how many required time points for the current task are already 'on'.
                (define covered-count 0)
                (for i from s to e
                  (when (vector-ref on-time i)
                    (set! covered-count (add1 covered-count))))

                ;; If the current task still needs more time points, turn on the latest possible ones.
                (when (< covered-count d)
                  (define needed (- d covered-count))
                  ;; Iterate backward from `e` down to `s`.
                  (for i down-from e to s
                    ;; If we still need more points and the current time point `i` is not yet 'on'.
                    (when (and (> needed 0) (not (vector-ref on-time i)))
                      ;; Turn on time point `i`.
                      (vector-set! on-time i #t)
                      ;; Increment the total count of 'on' time points.
                      (set! total-on-time (add1 total-on-time))
                      ;; Decrement the number of points still needed for this task.
                      (set! needed (sub1 needed)))))))
            sorted-tasks)

  ;; Return the total number of 'on' time points, which is the minimum time.
  total-on-time)