(define (evalRPN tokens)
  (let ([stack '()])
    (for ([token tokens])
      (cond
        [(equal? token "+") 
         (let ([b (car stack)] [a (cadr stack)])
           (set! stack (cons (+ a b) (cddr stack))))]
        [(equal? token "-") 
         (let ([b (car stack)] [a (cadr stack)])
           (set! stack (cons (- a b) (cddr stack))))]
        [(equal? token "*") 
         (let ([b (car stack)] [a (cadr stack)])
           (set! stack (cons (* a b) (cddr stack))))]
        [(equal? token "/") 
         (let ([b (car stack)] [a (cadr stack)])
           (set! stack (cons (truncate (/ a b)) (cddr stack))))]
        [else (set! stack (cons (string->number token) stack))]))
    (car stack)))