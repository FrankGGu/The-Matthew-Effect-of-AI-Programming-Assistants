(define (max-tasks tasks workers pills strength)
  (define (check mid)
    (define sorted-tasks (list->vector (sort (take tasks mid) >)))
    (define sorted-workers (list->vector (sort workers <)))
    (define p pills)
    (define (helper task-idx worker-idx)
      (cond
        [(>= task-idx mid) #t]
        [(>= worker-idx (vector-length sorted-workers)) #f]
        [else
         (if (>= (vector-ref sorted-workers worker-idx) (vector-ref sorted-tasks task-idx))
             (helper (+ task-idx 1) (+ worker-idx 1))
             (if (> p 0)
                 (if (>= (+ (vector-ref sorted_workers worker-idx) strength) (vector-ref sorted_tasks task-idx))
                     (begin
                       (set! p (- p 1))
                       (helper (+ task-idx 1) (+ worker-idx 1)))
                     #f)
                 #f))]))
    (set! p pills)
    (helper 0 0))

  (define (binary-search left right)
    (cond
      [(> left right) right]
      [else
       (let ((mid (floor (/ (+ left right) 2))))
         (if (check mid)
             (binary-search (+ mid 1) right)
             (binary-search left (- mid 1))))]))

  (binary-search 0 (length tasks)))