(define (score-of-parentheses s)
  (let loop ([s (string->list s)] [depth 0])
    (cond
      [(null? s) 0]
      [(equal? (car s) #\()
       (let-values ([(score rest) (loop (cdr s) (+ depth 1))])
         (if (equal? (car rest) #\))
             (+ (expt 2 depth) score (loop (cdr rest) depth))
             (error "Invalid parentheses sequence")))]
      [(equal? (car s) #\))
       (values 0 (cdr s))]
      [else (error "Invalid character in string")])))