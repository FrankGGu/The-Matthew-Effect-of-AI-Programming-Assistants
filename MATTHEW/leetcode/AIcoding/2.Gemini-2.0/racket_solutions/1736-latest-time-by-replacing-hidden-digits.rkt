(define (latest-time-by-replacing-hidden-digits time)
  (define (replace-question-marks time)
    (define (replace-at index char time)
      (string-append (substring time 0 index)
                     (string char)
                     (substring time (+ index 1) (string-length time))))

    (define (replace-recursive time index)
      (cond
        [(>= index (string-length time)) time]
        [(char=? (string-ref time index) #\?)
         (cond
           [(= index 0)
            (replace-recursive (replace-at time index (if (or (char=? (string-ref time 1) #\?) (<= (string->number (string (string-ref time 1))) 3)) #\2 #\1)) (+ index 1))]
           [(= index 1)
            (replace-recursive (replace-at time index (if (char=? (string-ref time 0) #\2) #\3 #\9)) (+ index 1))]
           [(= index 3)
            (replace-recursive (replace-at time index #\5) (+ index 1))]
           [(= index 4)
            (replace-recursive (replace-at time index #\9) (+ index 1))]
           [else time])]
        [else
         (replace-recursive time (+ index 1))]))

    (replace-recursive time 0))

  (replace-question-marks time))