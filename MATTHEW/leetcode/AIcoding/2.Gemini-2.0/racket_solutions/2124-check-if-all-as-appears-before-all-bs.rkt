(define (check-string s)
  (define (helper str seen-b?)
    (cond
      [(empty? str) #t]
      [(equal? (car str) #\a) (if seen-b? #f (helper (cdr str) seen-b?))]
      [(equal? (car str) #\b) (helper (cdr str) #t)]
      [else #f]))
  (helper (string->list s) #f))