(define (basic-calculator-iv expression evalvars evalints)
  (define vars (map cons evalvars evalints))

  (define (tokenize s)
    (let loop ([s (string-trim s)] [tokens '()])
      (cond
        [(string=? s "") (reverse tokens)]
        [(char-alphabetic? (string-ref s 0))
         (let ([end (for/first ([i (in-range (string-length s))])
                      (when (not (or (char-alphabetic? (string-ref s i)) (char-numeric? (string-ref s i))))
                        i)
                      #f)])
           (let ([end (if end end (string-length s))])
             (let ([token (substring s 0 end)])
               (loop (string-trim (substring s end)) (cons token tokens)))))]
        [(char-numeric? (string-ref s 0))
         (let ([end (for/first ([i (in-range (string-length s))])
                      (when (not (char-numeric? (string-ref s i)))
                        i)
                      #f)])
           (let ([end (if end end (string-length s))])
             (let ([token (substring s 0 end)])
               (loop (string-trim (substring s end)) (cons token tokens)))))]
        [else
         (loop (string-trim (substring s 1)) (cons (string (string-ref s 0))) tokens)])))

  (define (parse tokens)
    (define (parse-expression tokens precedence)
      (define (apply-op op left right)
        (cond
          [(string=? op "+") (hash-map left (lambda (k v) (+ v (hash-ref right k 0))))]
          [(string=? op "-") (hash-map left (lambda (k v) (- v (hash-ref right k 0))))]
          [(string=? op "*") (let ([result (make-hash)])
                                  (hash-for-each left (lambda (k1 v1)
                                                        (hash-for-each right (lambda (k2 v2)
                                                                              (let ([new-key (sort (append k1 k2) string<?)])
                                                                                (hash-update result new-key (lambda (x) (+ x (* v1 v2))) 0))))))
                                  result)]
          [else (error "Unknown operator: " op)]))

      (define (next-token tokens)
        (if (null? tokens) (values #f '()) (values (car tokens) (cdr tokens))))

      (let-values ([(token remaining-tokens) (next-token tokens)])
        (cond
          [(not token) (values (make-hash) tokens)]
          [(string=? token "(")
           (let-values ([(left new-tokens) (parse-expression remaining-tokens 0)])
             (let-values ([(next-tok final-tokens) (next-token new-tokens)])
               (if (string=? next-tok ")")
                   (values left final-tokens)
                   (error "Expected ')'"))))]
          [(char-alphabetic? (string-ref token 0))
           (let ([value (assoc token vars)])
             (if value
                 (values (hash (list) (cdr value)) remaining-tokens)
                 (values (hash (list token) 1) remaining-tokens)))]
          [(char-numeric? (string-ref token 0))
           (values (hash (list) (string->number token)) remaining-tokens)]
          [else
           (error "Unexpected token: " token)]))

      (let loop ([left (make-hash)] [tokens tokens])
        (let-values ([(token remaining-tokens) (next-token tokens)])
          (cond
            [(not token) (values left tokens)]
            [(or (string=? token ")") (string=? token "(")) (values left tokens)]
            [(or (string=? token "+") (string=? token "-") (string=? token "*"))
             (let ([op token])
               (let ([op-precedence (cond [(string=? op "*") 2] [else 1])])
                 (if (< precedence op-precedence)
                     (let-values ([(right new-tokens) (parse-expression remaining-tokens op-precedence)])
                       (loop (apply-op op left right) new-tokens))
                     (values left tokens))))]
            [else (values left tokens)]))))

    (let-values ([(result _) (parse-expression tokens 0)])
      result))

  (define result (parse (tokenize expression)))

  (define sorted-result
    (sort (hash-keys result)
          (lambda (x y)
            (cond
              [(> (length x) (length y)) #t]
              [(< (length x) (length y)) #f]
              [else (apply string<? (append (list x) (list y)))]))))

  (map (lambda (k)
         (if (null? k)
             (number->string (hash-ref result k 0))
             (list->string k)))
       (filter (lambda (k) (> (hash-ref result k 0) 0)) sorted-result)))