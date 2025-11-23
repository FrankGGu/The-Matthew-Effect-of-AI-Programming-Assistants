(define (account-balance-after-rounded-purchase purchaseAmount)
  (let* ([remainder (modulo purchaseAmount 10)]
         [rounded-purchase (cond
                             [(< remainder 5) (- purchaseAmount remainder)]
                             [else (+ purchaseAmount (- 10 remainder))])])
    (- 100 rounded-purchase)))