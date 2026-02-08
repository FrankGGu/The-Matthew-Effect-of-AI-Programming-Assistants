(define (backspace-compare s t)
  (define (process str)
    (let loop ([chars (string->list str)] [result '()])
      (cond [(empty? chars) (list->string (reverse result))]
            [(char=? (car chars) #\#) (if (empty? result)
                                          (loop (cdr chars) result)
                                          (loop (cdr chars) (cdr result)))]
            [else (loop (cdr chars) (cons (car chars) result))])))
  (equal? (process s) (process t)))