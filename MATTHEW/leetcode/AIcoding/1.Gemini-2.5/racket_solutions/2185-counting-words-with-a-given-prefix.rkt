(define/public (prefix-count words pref)
  (for/sum ([word words])
    (if (string-prefix? pref word)
        1
        0)))