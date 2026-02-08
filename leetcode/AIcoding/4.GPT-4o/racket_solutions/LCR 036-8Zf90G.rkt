(define (evalRPN tokens)
  (define stack '())
  (define (apply-op op a b)
    (cond
      [(equal? op "+") (+ b a)]
      [(equal? op "-") (- b a)]
      [(equal? op "*") (* b a)]
      [(equal? op "/") (quotient b a)]))
  (for-each
   (lambda (token)
     (cond
       [(or (equal? token "+") (equal? token "-") (equal? token "*") (equal? token "/"))
        (let ([a (car stack)]
              [b (cadr stack)])
          (set! stack (cons (apply-op token a b) (cddr stack))))]
       [else
        (set! stack (cons (string->number token) stack))]))
   tokens)
  (car stack))

(evalRPN '("2" "1" "+" "3" "*")) ; Example test case