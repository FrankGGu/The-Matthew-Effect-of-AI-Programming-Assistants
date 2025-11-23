(define (maximum-wealth accounts)
  (apply max (map (lambda (customer-accounts)
                    (apply + customer-accounts))
                  accounts)))