(define/contract (find-words-containing words x)
  (-> (listof string?) char? (listof exact-integer?))
  (for/list ([(word idx) (in-indexed words)]
             #:when (member x (string->list word)))
    idx))