#lang racket

(define (parse l)
  (define (eval exp env)
    (cond
      [(number? exp) exp]
      [(symbol? exp) (hash-ref env exp 0)]
      [(equal? (car exp) 'add) (+ (eval (cadr exp) env) (eval (caddr exp) env))]
      [(equal? (car exp) 'mult) (* (eval (cadr exp) env) (eval (caddr exp) env))]
      [(equal? (car exp) 'let) 
       (let ([new-env (hash-copy env)])
         (for ([i (in-range (length (cadr exp)))])
           (hash-set! new-env (caar (cadr exp)) (eval (cadar (cadr exp)) new-env)))
         (eval (caddr exp) new-env)))]))

  (define (parse-expr s)
    (cond
      [(number? s) s]
      [(symbol? s) s]
      [(equal? (car s) '(') (parse-expr (cdr s))]
      [else (list (string->symbol (substring (string-append "(" s ")") 1 (- (string-length s) 1))))]))

  (eval (parse-expr l) (hash))
)