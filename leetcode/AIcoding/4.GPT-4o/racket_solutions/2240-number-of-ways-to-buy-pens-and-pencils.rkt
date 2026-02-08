(define (waysToBuyPensPencils totalCost cost1 cost2)
  (let loop ((total totalCost) (pens 0) (ways 0))
    (if (> total 0)
        (loop (- total cost1) (+ pens 1) (+ ways (quotient (+ total cost2) cost2)))
        ways)))

(define (numWays totalCost cost1 cost2)
  (loop totalCost 0 0))