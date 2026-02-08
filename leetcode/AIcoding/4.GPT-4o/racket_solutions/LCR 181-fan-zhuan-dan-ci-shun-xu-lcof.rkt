(define (reverseWords s)
  (define words (string-split s))
  (define reversed (reverse words))
  (string-join reversed " "))