(define (remove-palindrome-subsequences s)
  (cond
    [(string=? s "") 0]
    [(string=? s (string-reverse s)) 1]
    [else 2]))