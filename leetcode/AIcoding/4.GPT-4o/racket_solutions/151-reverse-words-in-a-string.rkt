(define (reverse-words s)
  (define words (filter (lambda (x) (not (string=? x ""))) (string-split s)))
  (string-join (reverse words) " "))