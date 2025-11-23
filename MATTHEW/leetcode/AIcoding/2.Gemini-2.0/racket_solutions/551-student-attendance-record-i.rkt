(define (check-record s)
  (let* ((absent-count (count (lambda (c) (equal? c #\A)) (string->list s)))
         (late-streak (let loop ((lst (string->list s)) (streak 0) (max-streak 0))
                         (cond
                           ((null? lst) max-streak)
                           ((equal? (car lst) #\L) (loop (cdr lst) (+ streak 1) (max max-streak (+ streak 1))))
                           (else (loop (cdr lst) 0 max-streak))))))
    (and (<= absent-count 1) (< late-streak 3))))