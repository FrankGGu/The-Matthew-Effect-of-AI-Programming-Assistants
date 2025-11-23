(define (remove-anagrams words)
  (define (is-anagram a b)
    (equal? (sort (string->list a) char<?)
            (sort (string->list b) char<?)))
  (define (helper prev result words)
    (cond [(null? words) (reverse result)]
          [(is-anagram prev (car words)) (helper prev result (cdr words))]
          [else (helper (car words) (cons (car words) result) (cdr words))]))
  (if (null? words)
      '()
      (helper (car words) '() (cdr words))))