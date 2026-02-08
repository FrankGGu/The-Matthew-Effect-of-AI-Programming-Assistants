(define/contract (max-profit prices)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([i 1] [profit 0] [prices prices])
    (if (>= i (length prices))
        profit
        (let ([diff (- (list-ref prices i) (list-ref prices (- i 1)))])
          (loop (+ i 1) (if (> diff 0) (+ profit diff) profit) prices))))))