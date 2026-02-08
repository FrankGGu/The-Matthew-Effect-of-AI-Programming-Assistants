(define (inventory-management stock low high)
  (for/sum ([x stock])
    (cond
      [(< x low) (- low x)]
      [(> x high) (- x high)]
      [else 0])))