#lang racket

(require racket/list)

(define (make-term coeff var-list) (cons coeff (sort var-list string<?)))
(define (term-coeff t) (car t))
(define (term-vars t) (cdr t))
(define (term-degree t) (length (term-vars t)))

(define (string-list<? l1 l2)
  (cond
    [(null? l1) (not (null? l2))]
    [(null? l2) #f]
    [(string<? (car l1) (car l2)) #t]
    [(string>? (car l1) (car l2)) #f]
    [else (string-list<? (cdr l1) (cdr l2))]))

(define (term-compare t1 t2)
  (let ([deg1 (term-degree t1)]
        [deg2 (term-degree t2)])
    (cond
      [(> deg1 deg2) #t]
      [(< deg1 deg2) #f]
      [else (string-list<? (term-vars t1) (term-vars t2))])))

(define (poly-normalize poly)
  (if (null? poly)
      '()
      (let* ([grouped (group-by term-vars poly equal?)]
             [combined (map (lambda (group)
                               (make-term (apply + (map term-coeff group))
                                          (term-vars (car group))))
                            grouped)]
             [filtered (filter (lambda (t) (not (zero? (term-coeff t)))) combined)])
        (sort filtered term-compare))))

(define (poly-add p1 p2)
  (poly-normalize (append p1 p2)))

(define (poly-sub p1 p2)
  (poly-normalize (append p1 (map (lambda (t) (make-term (- (term-coeff t)) (term-vars t))) p2))))

(define (poly-mul p1 p2)
  (let ([result-terms '()])
    (for-each (lambda (t1)
                (for-each (lambda (t2)
                            (set! result-terms
                                  (cons (make-term (* (term-coeff t1) (term-coeff t2))
                                                   (append (term-vars t1) (term-vars t2)))
                                        result-terms)))
                          p2))
              p1)
    (poly-normalize result-terms)))

(define (poly-to-strings poly)
  (map (lambda (t)
         (let ([coeff (term-coeff t)]
               [vars (term-vars t)])
           (if (null? vars)
               (number->string coeff)
               (string-join (cons (number->string coeff) vars) "*"))))
       poly))

(define (tokenize s)
  (define (iter s acc)
    (cond
      [(string-empty? s) (reverse acc)]
      [(char-whitespace? (string-ref s 0)) (iter (substring s 1) acc)]
      [(char=? (string-ref s 0) '(') (iter (substring s 1) (cons '(' acc))]
      [(char=? (string-ref s 0) ')') (iter (substring s 1) (cons ')' acc))]
      [(char=? (string-ref s 0) '+) (iter (substring s 1) (cons '+ acc))]
      [(char=? (string-ref s 0) '-) (iter (substring s 1) (cons '- acc))]
      [(char=? (string-ref s 0) '*) (iter (substring s 1) (cons '* acc))]
      [(char-numeric? (string-ref s 0))
       (let-values ([(num-str rest) (regexp-match #rx"^[0-9]+" s)])
         (iter rest (cons (string->number (car num-str)) acc)))]
      [(char-alphabetic? (string-ref s 0))
       (let-values ([(var-str rest) (regexp-match #rx"^[a-z]+" s)])
         (iter rest (cons (car var-str) acc)))]
      [else (error "Invalid character in expression")])))

(define (parse-primary tokens env)
  (let ([token (car tokens)])
    (cond
      [(number? token) (values (list (make-term token '())) (cdr tokens))]
      [(string? token)
       (if (hash-has-key? env token)
           (values (list (make-term (hash-ref env token) '())) (cdr tokens))
           (values (list (make-term 1 (list token))) (cdr tokens)))]
      [(eq? token '(')
       (let-values ([(expr-poly rest-tokens) (parse-expression (cdr tokens) env)])
         (unless (eq? (car rest-tokens) ')') (error "Expected ')'"))
         (values expr-poly (cdr rest-tokens)))]
      [else (error "Unexpected token" token)])))

(define (parse-term tokens env)
  (let-values ([(left-poly rest-tokens) (parse-primary tokens env)])
    (let loop ([current-poly left-poly] [current-tokens rest-tokens])
      (if (and (not (null? current-tokens)) (eq? (car current-tokens) '*))
          (let-values ([(right-poly next-tokens) (parse-primary (cdr current-tokens) env)])
            (loop (poly-mul current-poly right-poly) next-tokens))
          (values current-poly current-tokens)))))

(define (parse-expression tokens env)
  (let-values ([(left-poly rest-tokens) (parse-term tokens env)])
    (let loop ([current-poly left-poly] [current-tokens rest-tokens])
      (if (and (not (null? current-tokens)) (or (eq? (car current-tokens) '+) (eq? (car current-tokens) '-)))
          (let ([op (car current-tokens)])
            (let-values ([(right-poly next-tokens) (parse-term (cdr current-tokens) env)])
              (loop (if (eq? op '+) (poly-add current-poly right-poly) (poly-sub current-poly right-poly))
                    next-tokens)))
          (values current-poly current-tokens)))))

(define (basic-calculator-iv expression evalvars evalints)
  (define var-env (make-hash))
  (for-each (lambda (i)
              (hash-set! var-env (list-ref evalvars i) (list-ref evalints i)))
            (range (length evalvars)))

  (let* ([tokens (tokenize expression)]
         [result-poly (car (call-with-values (lambda () (parse-expression tokens var-env)) list))])
    (poly-to-strings result-poly)))