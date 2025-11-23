(define (shortest-palindrome s)
  (define (is-palindrome? str)
    (equal? str (list->string (reverse (string->list str)))))

  (let loop ((i (string-length s)))
    (if (is-palindrome? (substring s 0 i))
        (string-append 
         (list->string (reverse (string->list (substring s i (string-length s)))))
        (loop (- i 1)))))