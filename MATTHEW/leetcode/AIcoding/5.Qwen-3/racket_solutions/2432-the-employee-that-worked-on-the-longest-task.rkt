(define (find-longest-task employees)
  (let loop ([employees employees] [max-time 0] [result '()])
    (if (null? employees)
        (car result)
        (let* ([name (caar employees)]
               [time (cadar employees)]
               [current-max (if (> time max-time) time max-time)])
          (loop (cdr employees)
                current-max
                (if (> time max-time)
                    (list name)
                    (if (= time max-time)
                        (cons name result)
                        result)))))))