(define (remove-outermost-parentheses S)
  (let loop ([s S] [level 0] [result '()])
    (if (null? s)
        (list->string (reverse result))
        (let ([c (car s)] [rest (cdr s)])
          (cond
            [(and (char=? c #\() (> level 0)) (loop rest (add1 level) (cons c result))]
            [(and (char=? c #\)) (> level 1)) (loop rest (sub1 level) (cons c result))]
            [(char=? c #\() (loop rest (add1 level) result)]
            [else (loop rest (sub1 level) result)])))))