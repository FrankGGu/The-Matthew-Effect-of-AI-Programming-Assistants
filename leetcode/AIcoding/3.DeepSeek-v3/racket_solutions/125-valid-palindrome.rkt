(define/contract (is-palindrome s)
  (-> string? boolean?)
  (let* ([s (string-downcase s)]
         [s (list->string (filter char-alphabetic? (string->list s)))])
    (equal? s (list->string (reverse (string->list s))))))