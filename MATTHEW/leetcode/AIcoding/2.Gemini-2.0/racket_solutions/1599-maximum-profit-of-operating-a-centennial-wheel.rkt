(define (min x y) (if (< x y) x y))

(define (max-profit customers boardingCost runningCost)
  (let loop ([wait (min customers 4)]
             [customers (- customers wait)]
             [profit 0]
             [rides 0]
             [on-board wait])
    (cond
      [(and (zero? customers) (zero? on-board)) profit]
      [(zero? customers)
       (let ([new-profit (+ profit (- (* on-board boardingCost) runningCost))])
         (if (> new-profit profit)
             (loop 0 0 new-profit (+ rides 1) 0)
             profit))]
      [else
       (let ([new-wait (min customers 4)])
         (let ([new-on-board (+ on-board new-wait)])
           (let ([boarded (min new-on-board 4)])
             (let ([new-profit (+ profit (- (* boarded boardingCost) runningCost))])
               (loop (- customers new-wait)
                     new-profit
                     (+ rides 1)
                     (- new-on-board boarded))))))])))
  (let* ([max-rides (quotient customers 4)]
         [profit-per-ride (- (* 4 boardingCost) runningCost)])
    (cond
      [(<= profit-per-ride 0)
       (loop (min customers 4) (- customers (min customers 4)) 0 0 (min customers 4))]
      [else
       (let* ([profit-from-max-rides (* max-rides profit-per-ride)]
              [remaining-customers (- customers (* max-rides 4))])
         (let ([profit-from-rem-customers (loop (min remaining-customers 4) (- remaining-customers (min remaining-customers 4)) 0 (+ max-rides 0) (min remaining-customers 4))])
           (max profit-from-rem-customers (+ profit-from-max-rides (loop (min remaining-customers 4) (- remaining-customers (min remaining-customers 4)) 0 (+ max-rides 0) (min remaining-customers 4))))))])))