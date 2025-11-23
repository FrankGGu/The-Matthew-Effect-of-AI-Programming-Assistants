(define (most-words-found sentences)
  (apply max (map (lambda (sentence) (length (string-split sentence))) sentences)))