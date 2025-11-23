(define (average-waiting-time customers)
  (let* ((num-customers (length customers))
         (initial-state (list 0 0)) ; (current-time total-waiting-time)
         (final-state
          (foldl (lambda (customer acc)
                   (let* ((arrival (car customer))
                          (prep (cadr customer))
                          (current-time-prev (car acc))
                          (total-waiting-time-prev (cadr acc))

                          (start-cooking (max current-time-prev arrival))
                          (finish-time (+ start-cooking prep))
                          (waiting-time (- finish-time arrival)))

                     (list finish-time (+ total-waiting-time-prev waiting-time))))
                 initial-state
                 customers)))
    (/ (exact->inexact (cadr final-state)) num-customers)))