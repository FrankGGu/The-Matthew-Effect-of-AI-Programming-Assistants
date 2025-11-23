(define (ways-to-buy-pens-pencils total pens cost1 pencils cost2)
  (let loop ([ways 0] [num-pens 0])
    (if (> (* num-pens cost1) total)
        ways
        (loop (+ ways (quotient (- total (* num-pens cost1)) cost2) 1) (+ num-pens 1)))))