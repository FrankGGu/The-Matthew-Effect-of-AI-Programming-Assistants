(define/contract (array-strings-are-equivalent word1 word2)
  (-> (listof string?) (listof string?) boolean?)
  (string=? (apply string-append word1) (apply string-append word2)))