(define (minimum-time-to-break-locks locks)
  (if (null? locks)
      0
      (apply min locks)))