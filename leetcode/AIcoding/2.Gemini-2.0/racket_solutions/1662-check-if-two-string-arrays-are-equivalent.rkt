(define (array-strings-are-equal word1 word2)
  (equal? (string-join word1 "") (string-join word2 "")))