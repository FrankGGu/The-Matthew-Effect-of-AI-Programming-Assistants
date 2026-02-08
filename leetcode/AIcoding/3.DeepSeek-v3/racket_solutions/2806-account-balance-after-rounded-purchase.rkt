(define/contract (account-balance-after-purchase purchase-amount)
  (-> exact-integer? exact-integer?)
  (let* ([rounded (* 10 (round (/ purchase-amount 10.0)))])
    (- 100 rounded)))