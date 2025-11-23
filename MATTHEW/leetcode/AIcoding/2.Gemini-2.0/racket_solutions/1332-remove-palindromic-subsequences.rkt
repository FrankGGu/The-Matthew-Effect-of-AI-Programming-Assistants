(define (remove-palindrome-subsequences s)
  (if (string=? s "")
      0
      (if (string=? s (string-reverse s))
          1
          2)))