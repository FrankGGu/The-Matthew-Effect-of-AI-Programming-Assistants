(define (range-addition-ii m n ops)
  (let loop ([ops ops]
             [min-a m]
             [min-b n])
    (cond
      [(null? ops) (* min-a min-b)]
      [else (let ([op (car ops)])
              (loop (cdr ops)
                    (min min-a (car op))
                    (min min-b (cadr op))))])))