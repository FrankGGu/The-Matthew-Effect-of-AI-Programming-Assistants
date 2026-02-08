(define (path-crossing path)
  (let loop ([path (string->list path)]
             [x 0]
             [y 0]
             [visited (hash (cons 0 0) #t)])
    (cond
      [(empty? path) #f]
      [else
       (let* ([move (car path)]
              [new-x (cond
                       [(char=? move #\N) x]
                       [(char=? move #\S) x]
                       [(char=? move #\E) (+ x 1)]
                       [(char=? move #\W) (- x 1)])]
              [new-y (cond
                       [(char=? move #\N) (+ y 1)]
                       [(char=? move #\S) (- y 1)]
                       [(char=? move #\E) y]
                       [(char=? move #\W) y])])
         (if (hash-has-key? visited (cons new-x new-y))
             #t
             (loop (cdr path) new-x new-y (hash-set visited (cons new-x new-y) #t))))])))