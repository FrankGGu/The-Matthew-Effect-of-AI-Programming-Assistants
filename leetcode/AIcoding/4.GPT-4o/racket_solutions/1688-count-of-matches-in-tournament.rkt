(define (numberOfMatches n)
  (if (= n 1)
      0
      (+ (quotient n 2) (numberOfMatches (ceiling (/ n 2))))))