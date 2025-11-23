(define (is-anagram s t)
  (equal? (sort (string->list s)) (sort (string->list t))))