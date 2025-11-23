(define (best-time-to-borrow books)
  (define (penalty books total)
    (if (null? books)
        total
        (let ((book (car books)))
          (penalty (cdr books) (if (equal? book #\Y) (1+ total) total)))))
  (define total-penalty (penalty (string->list books) 0))
  (if (zero? total-penalty)
      0
      total-penalty))

(define (min-penalty-for-shop schedule)
  (best-time-to-borrow schedule))