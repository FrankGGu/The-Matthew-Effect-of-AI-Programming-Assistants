(define (min-operations k)
  (if (<= k 1)
      0
      (let loop ([a 1] [b 1] [ops 0])
        (cond
          [(>= (+ a b) k) ops]
          [(< a b) (loop (+ a 1) b (+ ops 1))]
          [else (loop a (+ b 1) (+ ops 1))]))))