(define (parseBoolExpr expr)
  (let loop ([s (string->list expr)])
    (match s
      [(list #\t) #t]
      [(list #\f) #f]
      [(list #\! rest ...) (not (loop rest))]
      [(list #\& #\( rest ...)
       (let-values ([(args remaining) (parse-args rest)])
         (andmap identity args))]
      [(list #\| #\( rest ...)
       (let-values ([(args remaining) (parse-args rest)])
         (ormap identity args))]
      [_ (error "Invalid expression")])))

(define (parse-args s)
  (let loop ([s s] [args '()])
    (match s
      [(list #\)) (values (reverse args) '())]
      [(list #\, rest ...) (loop rest args)]
      [_
       (let-values ([(arg remaining) (parse-expr s)])
         (loop remaining (cons arg args))])))

(define (parse-expr s)
  (let ([result (parseBoolExpr (list->string s))])
    (let loop ([i 1])
      (if (or (>= i (length s))
              (char=? (list-ref s i) #\,)
              (char=? (list-ref s i) #\)))
          (values result (list-tail s i))
          (loop (add1 i))))))