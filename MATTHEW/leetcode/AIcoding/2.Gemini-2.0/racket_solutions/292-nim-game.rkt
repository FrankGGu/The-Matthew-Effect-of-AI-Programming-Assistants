(define (canWinNim n)
  (not (zero? (modulo n 4))))