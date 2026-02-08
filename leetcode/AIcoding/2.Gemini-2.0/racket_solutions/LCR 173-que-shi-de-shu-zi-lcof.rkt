(define (attendanceRecord s)
  (let* ([absences (string-count s "A")]
         [late-streak (regexp-match #rx"L{3,}" s)])
    (and (<= absences 1) (not late-streak))))