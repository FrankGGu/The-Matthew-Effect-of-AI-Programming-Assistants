(define (truncate-sentence s k)
  (string-join (take (string-split s) k) " "))