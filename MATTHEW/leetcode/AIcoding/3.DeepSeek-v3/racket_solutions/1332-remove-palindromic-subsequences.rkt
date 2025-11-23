(define/contract (remove-palindrome-sub s)
  (-> string? exact-integer?)
  (if (equal? s (list->string (reverse (string->list s))))
      1
      2))