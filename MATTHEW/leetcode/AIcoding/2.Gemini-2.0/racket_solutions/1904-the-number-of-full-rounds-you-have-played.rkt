(define (number-of-full-rounds startTime finishTime)
  (define (time-to-minutes time)
    (let ([parts (string-split time ":")])
      (+ (* (string->number (car parts)) 60) (string->number (cadr parts)))))

  (define start-minutes (time-to-minutes startTime))
  (define finish-minutes (time-to-minutes finishTime))

  (define (calculate-rounds start finish)
    (let* ([start-round-start (+ start (- (remainder start 15))) ]
           [start-round-end (+ start 15 (- (remainder start 15))) ]
           [finish-round-end (- finish (remainder finish 15))]
           [diff (- finish-round-end start-round-start)])
      (if (> finish start)
          (if (<= diff 0)
              0
              (/ diff 15))
          0)))

  (if (<= finish-minutes start-minutes)
      (calculate-rounds start-minutes (+ finish-minutes 1440))
      (calculate-rounds start-minutes finish-minutes)))