(define (are-digits-equal s)
  (let ([first-digit (string-ref s 0)])
    (for/all ([i (in-range (string-length s))])
      (equal? (string-ref s i) first-digit))))