(define (score-of-string s)
  (let loop ([s (string->list s)]
             [score 0])
    (cond
      [(empty? s) score]
      [(char=? (car s) #\a) (loop (cdr s) (+ score 1))]
      [(char=? (car s) #\e) (loop (cdr s) (+ score 2))]
      [(char=? (car s) #\i) (loop (cdr s) (+ score 3))]
      [(char=? (car s) #\o) (loop (cdr s) (+ score 4))]
      [(char=? (car s) #\u) (loop (cdr s) (+ score 5))]
      [else (loop (cdr s) score)])))