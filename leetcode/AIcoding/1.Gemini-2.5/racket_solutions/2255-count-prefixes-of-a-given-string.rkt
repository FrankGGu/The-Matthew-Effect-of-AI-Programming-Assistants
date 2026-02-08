(define (count-prefixes words s)
  (for/sum ([word words])
    (if (string-prefix? word s) 1 0)))