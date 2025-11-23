(define (find-words words x)
  (for/list ([word-str index (in-indexed words)]
             #:when (string-contains? word-str x))
    index))