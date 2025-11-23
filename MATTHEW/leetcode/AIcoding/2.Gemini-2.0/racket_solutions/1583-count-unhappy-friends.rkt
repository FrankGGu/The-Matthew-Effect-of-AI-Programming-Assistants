(define (count-unhappy-friends n preferences pairs)
  (define (is-happier x y)
    (let loop ([lst (list-ref preferences x)])
      (cond
        [(empty? lst) #f]
        [(equal? (car lst) y) #f]
        [else (let ([w (car lst)])
                (if (ormap (lambda (p) (and (equal? (car p) w) (equal? (cadr p) x))) pairs)
                    #t
                    (loop (cdr lst))))])))
  (length (filter (lambda (x)
                     (ormap (lambda (p)
                              (and (equal? (car p) x) (is-happier x (cadr p))))
                            pairs))
                   (range 0 n))))