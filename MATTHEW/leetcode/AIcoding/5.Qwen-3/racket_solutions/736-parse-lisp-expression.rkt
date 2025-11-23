#lang racket

(define (parse-lisp s)
  (define (tokenize s)
    (let loop ([s s] [tokens '()] [current ""])
      (cond [(null? s) (reverse (if (equal? current "") tokens (cons current tokens)))]
            [(char-whitespace? (car s)) (loop (cdr s) (if (equal? current "") tokens (cons current tokens)) "")]
            [(char=? #\() (loop (cdr s) (if (equal? current "") tokens (cons current tokens)) "")]
            [(char=? #\)) (loop (cdr s) (if (equal? current "") tokens (cons current tokens)) "")]
            [else (loop (cdr s) tokens (string-append current (string (car s))))])))

  (define (eval-exp env exprs)
    (cond [(null? exprs) '()]
          [(equal? (car exprs) "if") (eval-if env (cdr exprs))]
          [(equal? (car exprs) "let") (eval-let env (cdr exprs))]
          [(equal? (car exprs) "add") (eval-add env (cdr exprs))]
          [(equal? (car exprs) "mult") (eval-mult env (cdr exprs))]
          [(number? (car exprs)) (car exprs)]
          [else (eval-var env (car exprs))]))

  (define (eval-if env exprs)
    (if (not (null? exprs))
        (let ([cond-val (eval-exp env (list (car exprs)))])
          (if (not (zero? cond-val))
              (eval-exp env (list (cadr exprs)))
              (eval-exp env (list (caddr exprs)))))
        '()))

  (define (eval-let env exprs)
    (let loop ([exprs exprs] [bindings '()])
      (if (null? exprs)
          (eval-exp (append bindings env) (cdr exprs))
          (let ([var (car exprs)])
            (if (equal? var ")")
                (eval-exp (append bindings env) (cdr exprs))
                (let ([val (eval-exp env (list (cadr exprs)))])
                  (loop (cddr exprs) (cons (cons var val) bindings)))))))

  (define (eval-add env exprs)
    (if (null? exprs)
        0
        (+ (eval-exp env (list (car exprs))) (eval-add env (cdr exprs))))

  (define (eval-mult env exprs)
    (if (null? exprs)
        1
        (* (eval-exp env (list (car exprs))) (eval-mult env (cdr exprs))))

  (define (eval-var env var)
    (cond [(null? env) (error "undefined variable")]
          [(equal? (caar env) var) (cdar env)]
          [else (eval-var (cdr env) var)]))

  (define (parse exprs env)
    (if (null? exprs)
        '()
        (cons (eval-exp env (list (car exprs))) (parse (cdr exprs) env))))

  (parse (tokenize s) '()))