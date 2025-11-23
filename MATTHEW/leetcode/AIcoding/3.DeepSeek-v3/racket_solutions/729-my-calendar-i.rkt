(define my-calendar%
  (class object%
    (super-new)
    (init-field [bookings '()])

    (define/public (book start end)
      (cond
        [(ormap (λ (b) (not (or (<= end (car b)) (>= start (cdr b))))) bookings) #f]
        [else (set! bookings (cons (cons start end) bookings)) #t]))))

(define (make-my-calendar) (new my-calendar%))