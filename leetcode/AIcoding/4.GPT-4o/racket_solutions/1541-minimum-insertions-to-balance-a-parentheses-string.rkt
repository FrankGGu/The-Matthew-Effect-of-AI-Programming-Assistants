(define (min-insertions s)
  (define (helper s open close)
    (cond
      ((null? s) (+ close (if (> open 0) open 0)))
      ((char=? (car s) #\() (helper (cdr s) (+ open 1) close))
      ((char=? (car s) #\)) 
       (if (> open 0)
           (helper (cdr s) (- open 1) close)
           (helper (cdr s) open (+ close 1))))
      (else (helper (cdr s) open close))))
  (helper (string->list s) 0 0))

(min-insertions "(()))") ; Example usage