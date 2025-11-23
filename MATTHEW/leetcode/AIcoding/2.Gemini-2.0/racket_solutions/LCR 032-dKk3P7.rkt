(define (is-anagram s t)
  (if (not (= (string-length s) (string-length t)))
      #f
      (let* ([s-chars (sort (string->list s) char<?)]
             [t-chars (sort (string->list t) char<?)])
        (equal? s-chars t-chars))))