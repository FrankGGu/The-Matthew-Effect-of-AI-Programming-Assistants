(define (MyCalendar)
  (define intervals '())

  (define (book start end)
    (for ([i intervals])
      (when (and (>= start (second i)) (< start (first i)))
        (error "Booking conflicts!")))
    (set! intervals (cons (cons end start) intervals))
    #t)

  (define (instance)
    (list book))

  instance)