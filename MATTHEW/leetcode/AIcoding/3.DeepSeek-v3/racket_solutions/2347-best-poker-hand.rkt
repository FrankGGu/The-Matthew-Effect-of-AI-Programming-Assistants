(define/contract (best-hand ranks suits)
  (-> (listof exact-integer?) (listof char?) string?)
  (cond
    [(andmap (lambda (s) (char=? s (first suits))) suits] "Flush"
    [(let ([counts (make-hash)])
       (for ([r ranks])
         (hash-update! counts r add1 0))
       (let ([max-count (apply max (hash-values counts))])
         (cond
           [(>= max-count 3) "Three of a Kind"
           [(= max-count 2) "Pair"
           [else "High Card"])))]))