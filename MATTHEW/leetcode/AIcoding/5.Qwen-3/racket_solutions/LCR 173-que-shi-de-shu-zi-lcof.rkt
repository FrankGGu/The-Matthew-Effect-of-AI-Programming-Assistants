(define (attendanceRecord s)
  (cond ((null? s) '())
        ((equal? (car s) #\A) (cons #\A (attendanceRecord (cdr s))))
        (else (cons #\P (attendanceRecord (cdr s))))))