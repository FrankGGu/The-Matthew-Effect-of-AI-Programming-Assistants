(define (find-words-containing-character words character)
  (filter (lambda (word) (string-contains? word (string character))) words))