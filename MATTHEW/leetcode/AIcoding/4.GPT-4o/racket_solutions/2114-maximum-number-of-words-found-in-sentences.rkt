(define (most-words sentences)
  (define (count-words sentence)
    (length (filter (lambda (word) (not (string-empty? word))) (string-split sentence))))
  (apply max (map count-words sentences)))