(define (final-value-after-operations operations)
  (let loop ([ops operations] [x 0])
    (cond
      [(null? ops) x]
      [(string=? (car ops) "++X") (loop (cdr ops) (+ x 1))]
      [(string=? (car ops) "X++") (loop (cdr ops) (+ x 1))]
      [else (loop (cdr ops) (- x 1))])))