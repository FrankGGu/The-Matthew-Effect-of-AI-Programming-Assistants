(define (find-words-using-char words char)
  (filter (lambda (word) (string-contains? word char)) words))