(define (maximum-score a b c)
  (let ([sum (+ a b c)]
        [max-val (max a b c)])
    (if (> max-val (- sum max-val))
        (- sum max-val)
        (quotient sum 2))))