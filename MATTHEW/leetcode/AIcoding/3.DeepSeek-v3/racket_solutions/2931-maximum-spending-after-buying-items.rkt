(define/contract (max-spending values)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let* ([rows (length values)]
         [cols (length (car values))]
         [flattened (sort (apply append values) >)]
         [total-days (* rows cols)])
    (for/sum ([day (in-range 1 (add1 total-days))]
             [val flattened]
             (* day val))))