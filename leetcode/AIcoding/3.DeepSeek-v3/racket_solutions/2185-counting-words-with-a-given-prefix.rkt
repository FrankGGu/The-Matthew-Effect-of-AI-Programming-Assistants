(define/contract (prefix-count words pref)
  (-> (listof string?) string? exact-integer?)
  (count (lambda (word) (string-prefix? word pref)) words))