(define (beautiful-array n)
  (let helper ([lst '(1)])
    (if (> (car lst) n)
        '()
        (let* ([odds (map (lambda (x) (- (* 2 x) 1)) lst)]
               [evens (map (lambda (x) (* 2 x)) lst]
               [new-lst (append odds evens)])
          (helper new-lst)))))