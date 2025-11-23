(define (check-if-binary-string-has-at-most-one-segment-of-ones s)
  (let loop ([s (string->list s)]
             [ones-found? #f]
             [zeros-found? #f])
    (cond
      [(empty? s) #t]
      [(char=? (car s) #\1)
       (cond
         [(and ones-found? zeros-found?) #f]
         [else (loop (cdr s) #t zeros-found?)])]
      [else
       (loop (cdr s) ones-found? #t)])))