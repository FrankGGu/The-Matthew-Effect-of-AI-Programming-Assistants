(define (countDaysTogether arriveAlice leaveAlice arriveBob leaveBob)
  (define (date-to-day date)
    (define parts (string-split date "-"))
    (define year (string->number (first parts)))
    (define month (string->number (second parts)))
    (define day (string->number (third parts)))
    (+ (* year 365) (* month 30) day))

  (define start-alice (date-to-day arriveAlice))
  (define end-alice (date-to-day leaveAlice))
  (define start-bob (date-to-day arriveBob))
  (define end-bob (date-to-day leaveBob))

  (define start (max start-alice start-bob))
  (define end (min end-alice end-bob))

  (max 0 (- end start)))