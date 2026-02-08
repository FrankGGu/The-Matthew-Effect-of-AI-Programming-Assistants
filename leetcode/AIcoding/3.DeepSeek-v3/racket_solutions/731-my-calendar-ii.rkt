(define my-calendar-two%
  (class object%
    (super-new)
    (init-field)
    (field [bookings '()]
           [overlaps '()])

    (define/public (book start end)
      (for ([o overlaps])
        (when (and (< (car o) end) (> (cdr o) start))
          (return #f)))
      (for ([b bookings])
        (when (and (< (car b) end) (> (cdr b) start))
          (set! overlaps (cons (cons (max (car b) start) (min (cdr b) end)) overlaps))))
      (set! bookings (cons (cons start end) bookings)
      #t)))

(define (make-my-calendar-two)
  (new my-calendar-two%))