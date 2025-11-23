(define/contract (buy-pens-pencils total cost1 cost2)
  (-> exact-integer? exact-integer? exact-integer? exact-integer?)
  (let loop ((remaining total) (count 0))
    (if (< remaining 0)
        count
        (loop (- remaining cost1) (+ count 1)))))