(define/contract (num-of-strings patterns word)
  (-> (listof string?) string? exact-integer?)
  (count (lambda (pattern) (string-contains? word pattern)) patterns))