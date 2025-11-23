(define (numberOfCuts n)
  (if (= n 1)
      0
      (if (even? n)
          (/ n 2)
          (quotient n 2 + 1))))