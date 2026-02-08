(define (canEnter securityTime timeLimit)
  (if (>= securityTime timeLimit)
      #f
      #t))