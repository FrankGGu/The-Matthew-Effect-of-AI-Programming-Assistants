(define (reverseString s)
  (define (helper lst)
    (if (null? lst)
        '()
        (cons (car (reverse lst)) (helper (cdr lst)))))
  (helper s))

(reverseString "hello")