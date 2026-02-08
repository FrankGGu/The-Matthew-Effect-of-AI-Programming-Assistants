(define (reverse-words s)
  (string-join (reverse (filter (λ (x) (not (string=? x ""))) (string-split s " "))) " "))