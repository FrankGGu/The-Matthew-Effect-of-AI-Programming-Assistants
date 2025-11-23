(define (minimize-array-length nums)
  (define (helper lst)
    (cond [(null? lst) '()]
          [(null? (cdr lst)) lst]
          [else
           (let ([a (car lst)]
                 [b (cadr lst)])
             (if (= a b)
                 (helper (cons a (cddr lst)))
                 (cons a (helper (cdr lst)))))]))
  (length (helper nums)))