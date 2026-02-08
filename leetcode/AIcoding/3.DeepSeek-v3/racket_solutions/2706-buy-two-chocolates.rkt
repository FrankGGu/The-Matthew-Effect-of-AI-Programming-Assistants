(define/contract (buy-choco prices money)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([sorted-prices (sort prices <)]
         [total (apply + (take sorted-prices 2))])
    (if (<= total money)
        (- money total)
        money)))