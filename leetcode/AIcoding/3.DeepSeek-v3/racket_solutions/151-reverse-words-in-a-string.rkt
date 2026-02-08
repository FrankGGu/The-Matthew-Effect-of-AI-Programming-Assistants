(define (reverse-words s)
  (string-join (reverse (filter non-empty-string? (string-split s " "))) " "))