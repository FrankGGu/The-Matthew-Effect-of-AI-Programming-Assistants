(define (evalRPN tokens)
  (define stack (make-mutable-vector 0))

  (define (push x)
    (set! stack (vector-append stack (vector x))))

  (define (pop)
    (define top (vector-ref stack (- (vector-length stack) 1)))
    (set! stack (vector-remove stack (- (vector-length stack) 1)))
    top)

  (for ([token tokens])
    (cond
      [(ormap (λ (op) (string=? token op)) '("+", "-", "*", "/"))
       (let* ([val2 (pop)]
              [val1 (pop)])
         (cond
           [(string=? token "+") (push (+ val1 val2))]
           [(string=? token "-") (push (- val1 val2))]
           [(string=? token "*") (push (* val1 val2))]
           [(string=? token "/") (push (truncate (/ val1 val2)))]))]
      [else (push (string->number token))]))

  (pop))