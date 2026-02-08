(define (isAnagram s t)
  (equal? (sort (string->list s) char<?) (sort (string->list t) char<?>)))