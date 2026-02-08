(define (checkPossibility nums)
  (define (helper nums modified)
    (cond
      [(null? (cdr nums)) #t]
      [(and (>= (car nums) (cadr nums)) (not modified))
       (or (helper (cons (cadr nums) (cddr nums)) #t)
           (helper (cons (car nums) (cddr nums)) #t))]
      [(and (>= (car nums) (cadr nums)) modified) #f]
      [else (helper (cdr nums) modified)]))
  (helper nums #f))

(checkPossibility '(4 2 3))