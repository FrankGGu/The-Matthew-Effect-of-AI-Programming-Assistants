(define (final-string s)
  (let loop ([chars (string->list s)]
             [result '()]
             [reverse? #f])
    (if (null? chars)
        (list->string (if reverse? (reverse result) result))
        (let ([current (car chars)])
          (if (char=? current #\i)
              (loop (cdr chars) result (not reverse?))
              (loop (cdr chars) 
                    (if reverse? 
                        (cons current result)
                        (append result (list current)))
                    reverse?))))))