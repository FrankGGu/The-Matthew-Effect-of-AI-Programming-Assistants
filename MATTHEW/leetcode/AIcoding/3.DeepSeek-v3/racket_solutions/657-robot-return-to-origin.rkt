(define (judge-circle moves)
  (let loop ([x 0] [y 0] [moves (string->list moves)])
    (if (null? moves)
        (and (zero? x) (zero? y))
        (let ([move (car moves)])
          (cond
            [(char=? move #\U) (loop x (add1 y) (cdr moves))]
            [(char=? move #\D) (loop x (sub1 y) (cdr moves))]
            [(char=? move #\L) (loop (sub1 x) y (cdr moves))]
            [(char=? move #\R) (loop (add1 x) y (cdr moves))])))))