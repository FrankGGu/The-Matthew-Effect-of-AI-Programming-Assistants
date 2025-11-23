(define (array-strings-are-equal word1 word2)
  (equal? (apply string-append word1) (apply string-append word2)))