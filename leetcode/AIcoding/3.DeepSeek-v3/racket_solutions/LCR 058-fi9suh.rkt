(define my-calendar%
  (class object%
    (super-new)
    (init-field [bookings '()])

    (define/public (book start end)
      (cond
        [(null? bookings)
         (set! bookings (cons (cons start end) bookings))
         #t]
        [else
         (let loop ([lst bookings])
           (cond
             [(null? lst)
              (set! bookings (cons (cons start end) bookings))
              #t]
             [(or (<= end (caar lst)) (>= start (cdar lst)))
              (loop (cdr lst))]
             [else #f])))])))