(define (min-time-to-break-locks locks)
  (let* ([sorted-locks (sort locks <)]
         [initial-state (list 0 0)])
    (cadr
     (foldl (lambda (lock-time state)
              (let ([current-cumulative-time (car state)]
                    [total-sum-of-completion-times (cadr state)])
                (let ([new-current-cumulative-time (+ current-cumulative-time lock-time)])
                  (list new-current-cumulative-time (+ total-sum-of-completion-times new-current-cumulative-time)))))
            initial-state
            sorted-locks))))