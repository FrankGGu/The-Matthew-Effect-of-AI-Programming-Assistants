(define (average-waiting-time customers)
  (let loop ([customers customers]
             [current-time 0]
             [total-waiting-time 0])
    (if (null? customers)
        (/ total-waiting-time (length customers))
        (let* ([arrival-time (caar customers)]
               [service-time (cadar customers)]
               [start-time (max arrival-time current-time)]
               [finish-time (+ start-time service-time)]
               [waiting-time (- start-time arrival-time)])
          (loop (cdr customers)
                finish-time
                (+ total-waiting-time waiting-time))))))