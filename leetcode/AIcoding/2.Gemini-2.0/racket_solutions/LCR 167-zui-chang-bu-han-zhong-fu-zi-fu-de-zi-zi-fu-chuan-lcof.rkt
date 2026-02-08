(define (break-down-attacks attacks)
  (cond [(empty? attacks) '()]
        [(string=? (car attacks) "A") (cons 1 (break-down-attacks (cdr attacks)))]
        [(string=? (car attacks) "B") (cons 2 (break-down-attacks (cdr attacks)))]
        [(string=? (car attacks) "C") (cons 3 (break-down-attacks (cdr attacks)))]
        [else (break-down-attacks (cdr attacks))]))