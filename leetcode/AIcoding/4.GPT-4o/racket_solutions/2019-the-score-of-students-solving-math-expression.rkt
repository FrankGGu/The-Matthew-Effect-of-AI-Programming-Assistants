(define (score-of-students s answers)
  (define (eval-exp exp)
    (define (helper tokens)
      (define (apply-op op a b)
        (cond
          [(equal? op '+) (+ a b)]
          [(equal? op '*) (* a b)]))
      (define (parse tokens)
        (if (null? tokens)
            '()
            (let ((token (car tokens)))
              (if (number? token)
                  (cons token (parse (cdr tokens)))
                  (let ((rest (parse (cdr tokens))))
                    (if (null? rest)
                        (list token)
                        (cons token rest)))))))
      (define (calc tokens)
        (if (null? tokens)
            '()
            (let ((first (car tokens))
                  (rest (cdr tokens)))
              (if (number? first)
                  (let loop ((lst rest) (acc first))
                    (cond
                      [(null? lst) acc]
                      [(equal? (car lst) '*) (loop (cdr lst) (apply-op '* acc (cadr lst)))]
                      [(equal? (car lst) '+) (loop (cdr lst) (+ acc (cadr lst)))]
                      [else (loop (cdr lst) acc)])))
                  (calc rest)))))
      (calc (parse (string->list exp))))
  (define correct-answer (eval-exp s))
  (define (score ans)
    (if (equal? ans correct-answer) 5
      (if (and (<= 0 ans) (<= ans 1000)) 2 0)))
  (define scores (map score answers))
  (define total (apply + scores))
  total)