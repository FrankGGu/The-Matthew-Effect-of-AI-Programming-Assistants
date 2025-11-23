(define (account-balance-after-purchase price)
  (let* ((rounded-price (round (/ price 10)))
         (nearest-multiple-of-10 (* rounded-price 10)))
    (- 100 nearest-multiple-of-10)))