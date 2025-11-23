(define (permute nums)
  (define (helper acc nums)
    (if (null? nums)
        (list acc)
        (apply append
               (map (lambda (n)
                      (helper (cons n acc) (remove n nums)))
                    nums))))
  (helper '() nums))

(define (permuteUnique nums)
  (define (unique lst)
    (if (null? lst) '()
        (cons (car lst) (unique (filter (lambda (x) (not (= x (car lst)))) (cdr lst))))))
  (define (helper acc nums)
    (if (null? nums)
        (list (reverse acc))
        (apply append
               (map (lambda (n)
                      (helper (cons n acc) (remove n nums)))
                    (unique nums)))))
  (helper '() nums))

(define (permute nums)
  (permuteUnique (sort nums <)))

(permute '(1 2 3))