(define (max-ice-cream-bars costs coins)
  (let loop ((sorted-costs (sort costs <)) (coins coins) (count 0))
    (cond
      [(null? sorted-costs) count]
      [(<= (car sorted-costs) coins)
       (loop (cdr sorted-costs) (- coins (car sorted-costs)) (+ count 1))]
      [else count])))