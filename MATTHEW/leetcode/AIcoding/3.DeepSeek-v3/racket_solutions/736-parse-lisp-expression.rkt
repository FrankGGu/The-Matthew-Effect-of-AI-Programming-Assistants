#lang racket

(define (evaluate expr)
  (define env (make-hash))
  (define (parse s)
    (let loop ([s s])
      (cond
        [(string-prefix? s "(") (let-values ([(res rest) (parse-list (substring s 1))])
                                  (cons res rest))]
        [(string-prefix? s "-") (let ([n (string->number s)])
                                  (if n (cons n "")
                                      (let ([sym (substring s 0 1)])
                                        (cons sym (substring s 1)))))]
        [(regexp-match #px"^[0-9]+" s) => (λ (m) (cons (string->number (car m)) (substring s (string-length (car m))))]
        [(regexp-match #px"^[a-zA-Z]+" s) => (λ (m) (cons (car m) (substring s (string-length (car m))))]
        [else (cons (substring s 0 1) (substring s 1))])))

  (define (parse-list s)
    (let loop ([res '()] [s s])
      (cond
        [(string-prefix? s ")") (values (reverse res) (substring s 1))]
        [(string-prefix? s " ") (loop res (substring s 1))]
        [else (let-values ([(x rest) (parse s)])
                (loop (cons x res) rest))])))

  (define (eval-expr expr env)
    (cond
      [(number? expr) expr]
      [(string? expr) (hash-ref env expr)]
      [(list? expr)
       (case (car expr)
         [("add") (+ (eval-expr (cadr expr) env) (eval-expr (caddr expr) env))]
         [("mult") (* (eval-expr (cadr expr) env) (eval-expr (caddr expr) env))]
         [("let")
          (let loop ([bindings (cdr expr)] [new-env (hash-copy env)])
            (if (null? (cdr bindings))
                (eval-expr (car bindings) new-env)
                (let* ([var (car bindings)]
                       [val (eval-expr (cadr bindings) new-env)])
                  (loop (cddr bindings) (hash-set new-env var val)))))]
         [else (error "unknown operator")])]
      [else (error "invalid expression")]))

  (let-values ([(parsed _) (parse expr)])
    (eval-expr parsed env)))