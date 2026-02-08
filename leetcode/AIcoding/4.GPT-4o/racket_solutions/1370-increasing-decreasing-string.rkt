(define (sortString s)
  (define (helper chars)
    (if (null? chars)
        ""
        (let* ((sorted (sort chars char<?))
               (first (car sorted))
               (next-chars (cdr sorted)))
          (string-append (string first)
                         (helper (remove first next-chars))))))
  (define char-list (string->list s))
  (helper char-list))

(sortString "aaaabbbbcccc") ; Example usage