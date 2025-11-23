(define (most-words-found sentences)
  (apply max (map (lambda (s) (length (string-split s " "))) sentences)))