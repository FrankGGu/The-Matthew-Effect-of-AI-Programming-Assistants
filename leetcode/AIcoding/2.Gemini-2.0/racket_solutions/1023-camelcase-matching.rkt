(define (camel-match queries pattern)
  (map (lambda (query) (camel-match? query pattern)) queries))

(define (camel-match? query pattern)
  (let loop ([q (string->list query)] [p (string->list pattern)])
    (cond
      [(and (null? q) (null? p)) #t]
      [(null? p)
       (if (ormap char-upper-case? q) #f #t)]
      [(null? q) #f]
      [(char=? (car q) (car p)) (loop (cdr q) (cdr p))]
      [(char-upper-case? (car q)) #f]
      [else (loop (cdr q) p)])))