(define (basic-calculator-iv expression evalvars evalints)
  (define (parse s)
    (let loop ([s s] [stack '()] [ops '()])
      (cond
        [(string=? s "") (let ([res (car stack)])
                           (if (null? ops) res (apply-op (car ops) (cadr stack) res)))]
        [(char-whitespace? (string-ref s 0)) (loop (substring s 1) stack ops)]
        [(char-numeric? (string-ref s 0))
         (let ([num (let loop ([i 0])
                      (if (and (< i (string-length s)) (char-numeric? (string-ref s i)))
                          (loop (+ i 1))
                          i))])
               (n (string->number (substring s 0 num))))
           (loop (substring s num) (cons n stack) ops))]
        [(char-alphabetic? (string-ref s 0))
         (let ([var (let loop ([i 0])
                      (if (and (< i (string-length s)) (char-alphabetic? (string-ref s i)))
                          (loop (+ i 1))
                          i))])
           (loop (substring s var) (cons (substring s 0 var) stack) ops))]
        [(member (string-ref s 0) '(#\+ #\- #\*))
         (let ([op (string-ref s 0)])
           (loop (substring s 1) stack (cons op ops)))]
        [(char=? (string-ref s 0) #\()
         (let ([end (find-paren s 1 0)])
           (loop (substring s (+ end 1)) (cons (parse (substring s 1 end)) stack) ops))]
        [else (loop (substring s 1) stack ops)])))

  (define (find-paren s i cnt)
    (cond
      [(>= i (string-length s)) i]
      [(char=? (string-ref s i) #\() (find-paren s (+ i 1) (+ cnt 1))]
      [(char=? (string-ref s i) #\)) (if (= cnt 0) i (find-paren s (+ i 1) (- cnt 1)))]
      [else (find-paren s (+ i 1) cnt)]))

  (define (apply-op op a b)
    (case op
      [(#\+) (add a b)]
      [(#\-) (sub a b)]
      [(#\*) (mul a b)]))

  (define (add a b)
    (cond
      [(and (number? a) (number? b)) (+ a b)]
      [(number? a) (if (= a 0) b (list '+ a b))]
      [(number? b) (if (= b 0) a (list '+ a b))]
      [else (list '+ a b)]))

  (define (sub a b)
    (cond
      [(and (number? a) (number? b)) (- a b)]
      [(number? a) (if (= a 0) (list '- b) (list '- a b))]
      [(number? b) (if (= b 0) a (list '- a b))]
      [else (list '- a b)]))

  (define (mul a b)
    (cond
      [(and (number? a) (number? b)) (* a b)]
      [(number? a) (if (= a 0) 0 (if (= a 1) b (list '* a b)))]
      [(number? b) (if (= b 0) 0 (if (= b 1) a (list '* a b)))]
      [else (list '* a b)]))

  (define (evaluate expr vars vals)
    (cond
      [(number? expr) expr]
      [(symbol? expr) (let ([pos (index-of vars expr)])
                        (if pos (list-ref vals pos) expr))]
      [else (let ([op (car expr)]
                 [args (map (lambda (e) (evaluate e vars vals)) (cdr expr))])
              (apply-op op (car args) (cadr args)))]))

  (define (simplify expr)
    (cond
      [(number? expr) expr]
      [(symbol? expr) expr]
      [else (let ([op (car expr)]
                  [args (map simplify (cdr expr))])
              (case op
                [(+) (let ([nums (filter number? args)]
                       [vars (filter (lambda (x) (not (number? x))) args)])
                       (let ([sum (apply + nums)])
                         (cond
                           [(null? vars) sum]
                           [(= sum 0) (if (null? (cdr vars)) (car vars) (cons '+ vars))]
                           [else (cons '+ (cons sum vars))])))]
                [(-) (let ([nums (filter number? args)]
                           [vars (filter (lambda (x) (not (number? x))) args)])
                       (let ([diff (apply - nums)])
                         (cond
                           [(null? vars) diff]
                           [(= diff 0) (if (null? (cdr vars)) (list '- (car vars)) (cons '- vars))]
                           [else (cons '- (cons diff vars))])))]
                [(*) (let ([nums (filter number? args)]
                           [vars (filter (lambda (x) (not (number? x))) args)])
                       (let ([prod (apply * nums)])
                         (cond
                           [(null? vars) prod]
                           [(= prod 0) 0]
                           [(= prod 1) (if (null? (cdr vars)) (car vars) (cons '* vars))]
                           [else (cons '* (cons prod vars))])))]
                [else expr]))]))

  (define (sort-terms expr)
    (cond
      [(or (number? expr) (symbol? expr)) expr]
      [else (let ([op (car expr)]
                  [args (cdr expr)])
              (cons op (sort (map sort-terms args) term<?)))]))

  (define (term<? a b)
    (cond
      [(and (symbol? a) (symbol? b)) (string<? (symbol->string a) (symbol->string b))]
      [(symbol? a) #f]
      [(symbol? b) #t]
      [(and (number? a) (number? b)) (< a b)]
      [(number? a) #f]
      [(number? b) #t]
      [else (let ([a-op (car a)]
                  [b-op (car b)])
              (cond
                [(not (eq? a-op b-op)) (term<? a-op b-op)]
                [else (let loop ([a-args (cdr a)]
                                 [b-args (cdr b)])
                        (cond
                          [(null? a-args) #t]
                          [(term<? (car a-args) (car b-args)) #t]
                          [(term<? (car b-args) (car a-args)) #f]
                          [else (loop (cdr a-args) (cdr b-args))]))]))]))

  (define (format-expr expr)
    (cond
      [(number? expr) (number->string expr)]
      [(symbol? expr) (symbol->string expr)]
      [else (string-append "(" (string-join (map format-expr expr) " ") ")")]))

  (let* ([parsed (parse expression)]
         [evaluated (evaluate parsed evalvars (map string->number evalints))]
         [simplified (simplify evaluated)]
         [sorted (sort-terms simplified)])
    (format-expr sorted)))