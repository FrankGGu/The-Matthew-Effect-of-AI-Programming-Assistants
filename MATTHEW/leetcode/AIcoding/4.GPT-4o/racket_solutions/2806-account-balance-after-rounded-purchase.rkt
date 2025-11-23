(define (accountBalanceAfterPurchase(purchaseAmount))
  (let ((balance 1000))
    (if (< purchaseAmount 0)
        (error "Purchase amount must be non-negative.")
        (let ((roundedAmount (if (zero? (modulo purchaseAmount 10))
                                  purchaseAmount
                                  (+ (* (floor (/ purchaseAmount 10)) 10) 10))))
          (max 0 (- balance roundedAmount))))))