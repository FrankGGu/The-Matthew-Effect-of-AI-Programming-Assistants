(define (count-special-characters s)
  (define special-chars (string->list "!@#$%^&*()_+[]{}|;':\",.<>?"))
  (define (is-special? c)
    (member c special-chars))
  (length (filter is-special? (string->list s))))

(define (count-special-characters-main s)
  (count-special-characters s))