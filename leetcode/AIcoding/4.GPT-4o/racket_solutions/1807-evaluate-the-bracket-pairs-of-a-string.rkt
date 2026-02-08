(define (evaluate-bracket-pairs s)
  (define stack '())
  (define result '())
  (for-each (lambda (ch)
              (cond
                [(equal? ch #\() (set! stack (cons (length result) stack))]
                [(equal? ch #\)) 
                 (let* ([start (car stack)]
                        [value (if (null? stack) 0 (car (last result)))])
                   (set! stack (cdr stack))
                   (set! result (append (take result start) (list (* 2 value))))))
                [else (set! result (append result (list (string->number (string ch)))))])))
            (string->list s))
  (if (null? result) 0 (apply + result)))