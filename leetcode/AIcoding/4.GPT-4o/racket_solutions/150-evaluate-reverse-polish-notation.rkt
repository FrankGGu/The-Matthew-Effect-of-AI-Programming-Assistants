(define (evalRPN tokens)
  (define stack '())
  (for ([token tokens])
    (cond
      [(string=? token "+")
       (define b (car stack))
       (set! stack (cdr stack))
       (define a (car stack))
       (set! stack (cdr stack))
       (set! stack (cons (+ a b) stack))]
      [(string=? token "-")
       (define b (car stack))
       (set! stack (cdr stack))
       (define a (car stack))
       (set! stack (cdr stack))
       (set! stack (cons (- a b) stack))]
      [(string=? token "*")
       (define b (car stack))
       (set! stack (cdr stack))
       (define a (car stack))
       (set! stack (cdr stack))
       (set! stack (cons (* a b) stack))]
      [(string=? token "/")
       (define b (car stack))
       (set! stack (cdr stack))
       (define a (car stack))
       (set! stack (cdr stack))
       (set! stack (cons (quotient a b) stack))]
      [else
       (set! stack (cons (string->number token) stack))]))
  (car stack))