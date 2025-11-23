(define (countSegments s)
  (if (string-empty? s)
      0
      (length (filter (lambda (x) (not (string-empty? x))) (string-split s " ")))))