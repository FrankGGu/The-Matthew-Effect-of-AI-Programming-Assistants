(define (are-digits-equal s)
  (let loop ([i 0])
    (cond
      [(>= i (string-length s)) #t]
      [else
       (let ([digit (string->number (substring s i (+ i 1)))])
         (if (equal? (modulo digit 2) (modulo i 2))
             (loop (+ i 1))
             #f))])))