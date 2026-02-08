(define (calculate s)
  (define (helper tokens)
    (define (eval op a b)
      (cond
        [(equal? op '+) (+ a b)]
        [(equal? op '-) (- a b)]
        [(equal? op '*) (* a b)]
        [(equal? op '/) (quotient a b)]))

    (define (get-next-token tokens)
      (if (null? tokens)
          '()
          (let ((token (car tokens)))
            (if (or (equal? token #\space) (equal? token #\tab))
                (get-next-token (cdr tokens))
                (cons token (cdr tokens))))))

    (define (parse-factor tokens)
      (let ((token (car tokens)))
        (cond
          ((equal? token #\() 
           (let-values (((result next-tokens) (parse-expression (cdr tokens))))
             (values result (cdr next-tokens))))
          ((number? token) 
           (values token (cdr tokens)))
          (else
           (error "Unexpected token")))))

    (define (parse-term tokens)
      (let-values (((factor next-tokens) (parse-factor tokens)))
        (define (loop acc tokens)
          (let ((next-token (car tokens)))
            (cond
              ((equal? next-token #\space) (loop acc (cdr tokens)))
              ((equal? next-token #\)) (values acc tokens))
              ((or (equal? next-token '*) (equal? next-token '/))
               (let ((op next-token))
                 (let-values (((next-factor next-next-tokens) (parse-factor (cdr tokens))))
                   (loop (eval op acc next-factor) next-next-tokens)))
              (else (values acc tokens)))))
        (loop factor next-tokens)))

    (define (parse-expression tokens)
      (let-values (((term next-tokens) (parse-term tokens)))
        (define (loop acc tokens)
          (let ((next-token (car tokens)))
            (cond
              ((equal? next-token #\space) (loop acc (cdr tokens)))
              ((equal? next-token #\)) (values acc tokens))
              ((or (equal? next-token '+) (equal? next-token '-))
               (let ((op next-token))
                 (let-values (((next-term next-next-tokens) (parse-term (cdr tokens))))
                   (loop (eval op acc next-term) next-next-tokens)))
              (else (values acc tokens)))))
        (loop term next-tokens)))

    (define tokens (string->list s))
    (let-values (((result next-tokens) (parse-expression tokens)))
      result))

(calculate "3 + 2 * 2")