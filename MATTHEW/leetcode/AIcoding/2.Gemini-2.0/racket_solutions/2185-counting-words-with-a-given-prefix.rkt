(define (prefix-count words pref)
  (length (filter (lambda (word) (string-prefix? pref word)) words)))