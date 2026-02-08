(define/contract (security-check customers)
  (-> (listof char?) (listof char?))
  (let loop ([customers customers]
             [queue '()]
             [result '()])
    (if (null? customers)
        (reverse (append (reverse queue) result))
        (let ([current (car customers)]
              [rest (cdr customers)])
          (cond
            [(char=? current #\M)
             (loop rest queue (cons current result))]
            [(char=? current #\F)
             (loop rest (cons current queue) result)]
            [else
             (loop rest queue (cons current result))])))))