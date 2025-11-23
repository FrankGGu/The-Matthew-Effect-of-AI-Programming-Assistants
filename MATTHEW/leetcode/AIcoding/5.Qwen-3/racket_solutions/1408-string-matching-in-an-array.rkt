(define (string-matching-in-an-array words)
  (define (is-substring? s t)
    (and (not (equal? s t)) (string-contains? t s)))
  (filter (lambda (w) (any (lambda (other) (is-substring? w other)) words)) words))