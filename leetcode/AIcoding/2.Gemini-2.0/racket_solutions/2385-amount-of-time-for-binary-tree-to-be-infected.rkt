(define (amount-of-time-to-infect root start)
  (define (depth node)
    (if (null? node)
        -1
        (max (depth (car node)) (depth (cdr node)))
        ))

  (define (dfs node start)
    (if (null? node)
        (values -1 -1) ; depth, time
        (let* ((left-depth-time (dfs (car node) start))
               (right-depth-time (dfs (cdr node) start))
               (left-depth (car left-depth-time))
               (left-time (cdr left-depth-time))
               (right-depth (car right-depth-time))
               (right-time (cdr right-depth-time)))
          (cond
            [(equal? (car node) start) (values 0 0)]
            [(>= left-depth 0) (values (+ left-depth 1) (+ 1 left-depth left-time))]
            [(>= right-depth 0) (values (+ right-depth 1) (+ 1 right-depth right-time))]
            [else (values (max left-depth right-depth) (max left-time right-time))]
            ))))

  (let* ((result (dfs root start))
         (depth-value (car result))
         (time-value (cdr result)))
    (if (>= depth-value 0)
        time-value
        (depth root)
        )))