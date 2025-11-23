(define/contract (maximum-wealth accounts)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (apply max (map (lambda (account) (apply + account)) accounts)))