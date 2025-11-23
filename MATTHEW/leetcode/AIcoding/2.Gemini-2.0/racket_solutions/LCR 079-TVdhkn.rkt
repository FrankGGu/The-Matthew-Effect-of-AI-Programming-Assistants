(define (subsets nums)
  (letrec ((helper (lambda (nums acc)
                      (cond
                        ((null? nums) (list acc))
                        (else (append (helper (cdr nums) acc)
                                      (helper (cdr nums) (cons (car nums) acc))))))))
    (map reverse (helper nums '()))))