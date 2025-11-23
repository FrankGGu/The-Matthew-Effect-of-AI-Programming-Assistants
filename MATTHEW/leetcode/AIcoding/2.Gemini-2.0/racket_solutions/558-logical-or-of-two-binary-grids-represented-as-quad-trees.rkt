(define (logical-or q1 q2)
  (cond
    [(and (equal? (car q1) #t) (equal? (car q2) #t)) (list #t #f #f #f #f)]
    [(and (equal? (car q1) #t) (equal? (car q2) #f)) (list #t #f #f #f #f)]
    [(and (equal? (car q1) #f) (equal? (car q2) #t)) (list #t #f #f #f #f)]
    [(and (equal? (car q1) #f) (equal? (car q2) #f)) (list #f #f #f #f #f)]
    [(equal? (car q1) #t) (list #t #f #f #f #f)]
    [(equal? (car q2) #t) (list #t #f #f #f #f)]
    [(equal? (car q1) #f) (list #f #f #f #f #f)]
    [(equal? (car q2) #f) (list #f #f #f #f #f)]
    [else
     (list #f
           (logical-or (cadr q1) (cadr q2))
           (logical-or (caddr q1) (caddr q2))
           (logical-or (cadddr q1) (cadddr q2))
           (logical-or (caddddr q1) (caddddr q2)))]))