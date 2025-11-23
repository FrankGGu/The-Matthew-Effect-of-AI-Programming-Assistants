(define (common-chars words)
  (let loop ([chars (string->list (car words))]
             [rest-words (cdr words)])
    (if (null? rest-words)
        (map string (sort chars char<?))
        (loop (filter (lambda (c) (member c (string->list (car rest-words)))) chars)
              (cdr rest-words)))))