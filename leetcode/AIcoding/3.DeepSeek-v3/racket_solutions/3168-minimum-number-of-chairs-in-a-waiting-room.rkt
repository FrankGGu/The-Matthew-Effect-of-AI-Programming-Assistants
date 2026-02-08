(define (minimum-chairs s)
  (let loop ([s s] [current 0] [max-chairs 0])
    (if (null? s)
        max-chairs
        (let ([event (car s)])
          (if (char=? event #\E)
              (let ([new-current (add1 current)]
                    [new-max (max max-chairs (add1 current))])
                (loop (cdr s) new-current new-max))
              (loop (cdr s) (sub1 current) max-chairs))))))