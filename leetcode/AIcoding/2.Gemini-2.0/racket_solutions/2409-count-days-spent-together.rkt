(define (count-days-spent-together arriveAlice leaveAlice arriveBob leaveBob)
  (define (date->days date)
    (let ([month (string->number (substring date 0 2)))
          [day (string->number (substring date 3 5))])
      (cond
        [(= month 1) day]
        [(= month 2) (+ 31 day)]
        [(= month 3) (+ 59 day)]
        [(= month 4) (+ 90 day)]
        [(= month 5) (+ 120 day)]
        [(= month 6) (+ 151 day)]
        [(= month 7) (+ 181 day)]
        [(= month 8) (+ 212 day)]
        [(= month 9) (+ 243 day)]
        [(= month 10) (+ 273 day)]
        [(= month 11) (+ 304 day)]
        [(= month 12) (+ 334 day)]
        [else 0])))

  (define alice-start (date->days arriveAlice))
  (define alice-end (date->days leaveAlice))
  (define bob-start (date->days arriveBob))
  (define bob-end (date->days leaveBob))

  (define start (max alice-start bob-start))
  (define end (min alice-end bob-end))

  (if (> start end)
      0
      (+ 1 (- end start))))