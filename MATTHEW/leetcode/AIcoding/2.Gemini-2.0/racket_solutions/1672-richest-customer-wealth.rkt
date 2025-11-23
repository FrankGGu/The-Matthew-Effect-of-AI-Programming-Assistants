(define (maximum-wealth accounts)
  (apply max (map (lambda (account) (apply + account)) accounts)))