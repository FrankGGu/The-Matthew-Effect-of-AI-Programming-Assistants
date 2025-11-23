(define (evalRPN tokens)
  (define (helper stack tokens)
    (cond
      [(empty? tokens) (car stack)]
      [else
       (let* ([token (car tokens)]
              [rest (cdr tokens)])
         (cond
           [(string=? token "+") (helper (cons (+ (cadr stack) (car stack)) (cddr stack)) rest)]
           [(string=? token "-") (helper (cons (- (cadr stack) (car stack)) (cddr stack)) rest)]
           [(string=? token "*") (helper (cons (* (cadr stack) (car stack)) (cddr stack)) rest)]
           [(string=? token "/") (helper (cons (truncate (/ (cadr stack) (car stack))) (cddr stack)) rest)]
           [else (helper (cons (string->number token) stack) rest)])))]))
  (helper '() tokens))