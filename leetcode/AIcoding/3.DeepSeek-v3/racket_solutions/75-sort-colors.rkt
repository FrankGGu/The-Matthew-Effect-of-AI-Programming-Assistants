(define/contract (sort-colors nums)
  (-> (listof exact-integer?) void?)
  (define (swap! i j)
    (define temp (list-ref nums i))
    (list-set! nums i (list-ref nums j))
    (list-set! nums j temp))
  (let loop ([low 0] [mid 0] [high (sub1 (length nums))])
    (when (<= mid high)
      (case (list-ref nums mid)
        [(0) (swap! low mid)
              (loop (add1 low) (add1 mid) high)]
        [(1) (loop low (add1 mid) high)]
        [(2) (swap! mid high)
             (loop low mid (sub1 high))]))))