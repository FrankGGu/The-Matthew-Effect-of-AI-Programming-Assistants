(define (maximumTime time)
  (define (replace-char c)
    (cond
      [(char=? c #\?) #\9]
      [(char=? c #\H) #\2]
      [(char=? c #\M) #\3]
      [else c]))
  (define (replace-time t)
    (string-append (string (replace-char (string-ref t 0)))
                   (string (replace-char (string-ref t 1)))
                   ":"
                   (string (replace-char (string-ref t 3)))
                   (string (replace-char (string-ref t 4)))))
  (let* [(new-time (replace-time time))
         (hour (string->number (substring new-time 0 2)))
         (minute (string->number (substring new-time 3 5)))]
    (if (and (>= hour 0) (< hour 24) (>= minute 0) (< minute 60))
        new-time
        time)))

(maximumTime "2?:?0")