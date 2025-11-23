(define/contract (is-palindrome x)
  (-> exact-integer? boolean?)
  (if (< x 0)
      #f
      (let ((s (number->string x)))
        (equal? s (list->string (reverse (string->list s)))))))