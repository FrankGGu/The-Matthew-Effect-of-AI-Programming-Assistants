(define (arrange-coins n)
  (let loop ([k 1] [coins n])
    (cond
      [(< coins k) (- k 1)]
      [else (loop (+ k 1) (- coins k))])))