(define (findLUSlength a b)
  (if (string=? a b)
      -1
      (max (string-length a) (string-length b))))