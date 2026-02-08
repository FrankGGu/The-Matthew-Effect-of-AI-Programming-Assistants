(define MyCalendar
  (class object%
    (super-new)
    (define slots '())
    (define/public (book start end)
      (for/or ([slot slots])
        (and (>= start (cdr slot)) (<= end (car slot))))
      (set! slots (cons (cons start end) slots))
      #t)))