(define (maxIceCream costs coins)
  (define sorted-costs (sort costs <))
  (define (helper coins costs count)
    (if (or (zero? coins) (null? costs))
        count
        (let ((current-cost (car costs)))
          (if (>= coins current-cost)
              (helper (- coins current-cost) (cdr costs) (+ count 1))
              count))))
  (helper coins sorted-costs 0))

(define (maxIceCreamBars costs coins)
  (maxIceCream costs coins))