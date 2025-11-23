(define (serialize root)
  (cond
    [(null? root) "#"]
    [else (string-append (number->string (car root)) ","
                         (serialize (cadr root)) ","
                         (serialize (caddr root)))]))

(define (deserialize data)
  (define (helper data-list)
    (if (empty? data-list)
        (values null data-list)
        (let ([val (car data-list)])
          (if (equal? val "#")
              (values null (cdr data-list))
              (let ([num (string->number val)])
                (let-values ([(left remaining1) (helper (cdr data-list))])
                  (let-values ([(right remaining2) (helper remaining1)])
                    (values (list num left right) remaining2))))))))
  (let ([data-list (string-split data ",")])
    (car (multiple-value-list (helper data-list)))))