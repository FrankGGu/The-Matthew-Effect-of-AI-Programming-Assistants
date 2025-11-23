(define (calculate s)
  (define (helper tokens)
    (define (eval op a b)
      (cond
        [(equal? op #\+) (+ a b)]
        [(equal? op #\-) (- a b)]
        [(equal? op #\*) (* a b)]
        [(equal? op #\/) (quotient a b)]))

    (define stack '())
    (define current 0)
    (define operation #\+)

    (for ([token tokens])
      (cond
        [(char-numeric? token) 
         (set! current (string->number (string-append (number->string current) (string token))))]
        [(equal? token #\+) 
         (set! stack (cons (eval operation current) stack))
         (set! current 0)
         (set! operation #\+)]
        [(equal? token #\-) 
         (set! stack (cons (eval operation current) stack))
         (set! current 0)
         (set! operation #\-)]
        [(equal? token #\*) 
         (set! current (eval #\* (car stack) current))
         (set! stack (cdr stack))]
        [(equal? token #\/) 
         (set! current (eval #\/ (car stack) current))
         (set! stack (cdr stack))]))

    (set! current (eval operation current))
    (apply + stack current))

  (define tokens (string->list (string-trim (string->list s))))
  (if (null? tokens) 0 (helper tokens)))