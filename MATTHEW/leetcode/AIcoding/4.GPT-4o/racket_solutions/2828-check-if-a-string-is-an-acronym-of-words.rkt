(define (isAcronym words s)
  (define acronym (apply string-append (map (lambda (word) (string-ref word 0)) words)))
  (equal? acronym s))