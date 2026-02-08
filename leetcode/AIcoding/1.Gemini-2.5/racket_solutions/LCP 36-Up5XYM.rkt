(define (max-deck-groups groups)
  (if (empty? groups)
      0
      (apply gcd groups)))