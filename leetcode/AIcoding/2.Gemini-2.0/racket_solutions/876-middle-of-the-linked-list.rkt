(define (middle-node head)
  (let loop ([slow head] [fast head])
    (cond [(null? fast) slow]
          [(null? (cdr fast)) slow]
          [else (loop (cdr slow) (cddr fast))])))