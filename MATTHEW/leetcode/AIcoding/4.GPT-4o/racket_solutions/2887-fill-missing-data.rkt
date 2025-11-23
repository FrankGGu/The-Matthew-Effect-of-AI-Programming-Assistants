(define (fillMissingData data)
  (define (fill-helper lst)
    (cond
      [(null? lst) '()]
      [(equal? (car lst) -1) 
       (let ([next (fill-helper (cdr lst))])
         (if (null? next)
             (list 0)
             (cons (/ (car next) 2) next)))]
      [else (cons (car lst) (fill-helper (cdr lst)))]))
  (fill-helper data))

(define (fillMissingDataWrapper data)
  (fillMissingData data))