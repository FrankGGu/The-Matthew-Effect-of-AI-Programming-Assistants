(define (first-palindrome words)
  (define (is-palindrome? s)
    (equal? s (string-reverse s)))

  (cond
    [(null? words) ""]
    [(is-palindrome? (car words)) (car words)]
    [else (first-palindrome (cdr words))]))