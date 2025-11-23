(define (make-strings-equal s target)
  (let loop ((i 0) (has-one? #f))
    (cond
      [(= i (string-length s))
       (let loop2 ((j 0) (has-one-target? #f))
         (cond
           [(= j (string-length target)) (equal? has-one? has-one-target?)]
           [(char=? (string-ref target j) #\1) (loop2 (add1 j) #t)]
           [else (loop2 (add1 j) has-one-target?)]))]
      [(char=? (string-ref s i) #\1) (loop (add1 i) #t)]
      [else (loop (add1 i) has-one?)])))