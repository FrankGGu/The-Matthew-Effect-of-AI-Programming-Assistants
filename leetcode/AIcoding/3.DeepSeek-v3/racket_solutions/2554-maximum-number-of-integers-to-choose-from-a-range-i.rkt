(define/contract (max-count banned n k)
  (-> (listof exact-integer?) exact-integer? exact-integer? exact-integer?)
  (let ([banned-set (list->set banned)])
    (let loop ([i 1] [count 0] [sum 0])
      (cond
        [(or (> i n) (> (+ sum i) k)) count]
        [(set-member? banned-set i) (loop (add1 i) count sum)]
        [else (loop (add1 i) (add1 count) (+ sum i))]))))