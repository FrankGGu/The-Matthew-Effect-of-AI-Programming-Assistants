(define/contract (gcd-of-strings str1 str2)
  (-> string? string? string?)
  (if (not (equal? (string-append str1 str2) (string-append str2 str1)))
      ""
      (let ((len (gcd (string-length str1) (string-length str2))))
          (substring str1 0 len)))