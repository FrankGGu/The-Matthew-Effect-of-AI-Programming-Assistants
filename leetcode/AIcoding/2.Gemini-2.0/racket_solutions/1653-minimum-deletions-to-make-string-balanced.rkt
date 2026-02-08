(define (min-deletions s)
  (let loop ([s (string->list s)] [a-count 0] [b-count 0] [min-del (length s)])
    (cond
      [(null? s) (min min-del b-count)]
      [(char=? (car s) #\a)
       (loop (cdr s) (+ a-count 1) b-count (min min-del (+ b-count)))]
      [else
       (loop (cdr s) a-count (+ b-count 1) (min min-del (+ a-count)))])))