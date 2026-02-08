(define (arrayStringsAreEqual word1 word2)
  (define (concat-strings arr)
    (apply string-append arr))
  (equal? (concat-strings word1) (concat-strings word2)))