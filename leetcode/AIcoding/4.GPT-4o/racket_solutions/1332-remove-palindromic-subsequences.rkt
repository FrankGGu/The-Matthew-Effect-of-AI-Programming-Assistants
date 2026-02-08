(define (remove-palindromic-subsequences s)
  (if (equal? s (reverse s))
      1
      2))