(define (deck-reveal deck)
  (define (shuffle lst)
    (if (null? lst)
        '()
        (cons (car lst) (shuffle (append (cddr lst) (list (cadr lst)))))))
  (define sorted-deck (sort deck <))
  (shuffle sorted-deck))

(deck-reveal '(17 13 11 2 3 5 7))