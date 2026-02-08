(define (smallestEvenMultiple n)
  (if (even? n)
      n
      (* 2 n)))