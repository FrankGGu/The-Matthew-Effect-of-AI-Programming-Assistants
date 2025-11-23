(define/contract (number-of-senior-citizens details)
  (-> (listof string?) exact-integer?)
  (length (filter (lambda (d) (>= (string->number (substring d 11 13)) 60)) details)))