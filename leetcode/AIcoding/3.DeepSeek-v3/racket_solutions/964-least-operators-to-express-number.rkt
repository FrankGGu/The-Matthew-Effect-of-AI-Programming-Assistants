(define (least-ops-express-number x target)
  (let loop ([pos (inexact->exact (ceiling (/ (log target) (log x))))]
    (let ([cost (if (zero? pos) 2 (pos))]
          [power (expt x pos)])
      (cond
        [(= power target) cost]
        [(< power target) (loop (add1 pos))]
        [else
         (let* ([next-power (expt x (sub1 pos))]
                [diff (- target next-power)]
                [cost1 (if (zero? (sub1 pos)) 2 (sub1 pos))]
                [cost2 (least-ops-express-number x diff)])
           (min (+ cost1 cost2)
                (let ([diff (- (* power) target)]
                      [cost3 (least-ops-express-number x diff)])
                  (+ cost pos cost3))))]))))