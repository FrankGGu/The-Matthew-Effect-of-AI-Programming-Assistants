(define (make-fancy-string s)
  (let loop ([str (string->list s)]
             [res '()])
    (cond
      [(null? str) (list->string (reverse res))]
      [(null? (cdr str)) (list->string (reverse (cons (car str) res)))]
      [(null? (cddr str)) (if (equal? (car str) (cadr str))
                               (list->string (reverse res))
                               (loop (cdr str) (cons (car str) res)))]
      [else (if (and (equal? (car str) (cadr str))
                      (equal? (car str) (caddr str)))
                (loop (cdr str) res)
                (loop (cdr str) (cons (car str) res)))])))