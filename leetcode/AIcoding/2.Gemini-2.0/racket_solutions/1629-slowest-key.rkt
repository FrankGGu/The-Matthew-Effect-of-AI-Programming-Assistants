(define (slowest-key release-times keys-pressed)
  (let loop ([times release-times]
             [keys (string->list keys-pressed)]
             [prev-time 0]
             [slowest-key #\a]
             [longest-duration 0])
    (cond
      [(null? times)
       slowest-key]
      [else
       (let* ([current-time (car times)]
              [current-key (car keys)]
              [duration (- current-time prev-time)])
         (cond
           [(> duration longest-duration)
            (loop (cdr times) (cdr keys) current-time current-key duration)]
           [(= duration longest-duration)
            (if (char>? current-key slowest-key)
                (loop (cdr times) (cdr keys) current-time current-key duration)
                (loop (cdr times) (cdr keys) current-time slowest-key longest-duration))]
           [else
            (loop (cdr times) (cdr keys) current-time slowest-key longest-duration)])))])))