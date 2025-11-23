(define (evalRPN tokens)
  (let ([stack '()])
    (for ([token tokens])
      (cond
        [(equal? token "+") 
         (let ([b (car stack)] 
           (set! stack (cdr stack)) 
         (let ([a (car stack)]) 
           (set! stack (cdr stack)) 
           (set! stack (cons (+ a b) stack))]
        [(equal? token "-") 
         (let ([b (car stack)]) 
           (set! stack (cdr stack)) 
         (let ([a (car stack)]) 
           (set! stack (cdr stack)) 
           (set! stack (cons (- a b) stack))]
        [(equal? token "*") 
         (let ([b (car stack)]) 
           (set! stack (cdr stack)) 
         (let ([a (car stack)]) 
           (set! stack (cdr stack)) 
           (set! stack (cons (* a b) stack))]
        [(equal? token "/") 
         (let ([b (car stack)]) 
           (set! stack (cdr stack)) 
         (let ([a (car stack)]) 
           (set! stack (cdr stack)) 
           (set! stack (cons (truncate (/ a b)) stack))]
        [else 
         (set! stack (cons (string->number token) stack))]))
    (car stack)))