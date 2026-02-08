(define (has-cycle? head)
  (let loop ([slow head] [fast head])
    (cond
      [(or (null? fast) (null? (cdr fast))) #f]
      [else (let ([new-slow (cdr slow)]
                  [new-fast (cddr fast)])
              (cond
                [(equal? new-slow new-fast) #t]
                [else (loop new-slow new-fast)]))])))