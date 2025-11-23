#lang racket

(define (get-max-profit customers boardingCost runningCost)
  (let* ((num-customers (vector-length customers)))
    (let loop ((customer-idx 0)
               (waiting-customers 0)
               (current-profit 0)
               (max-profit (- (expt 10 10))) ; Initialize max_profit to a very small number
               (max-profit-minute -1) ; Initial max_profit_minute
               (minutes-run 0)
               (any-customer-boarded? #f)) ; Flag to track if any customer was boarded

      (let* ((new-arrivals (if (< customer-idx num-customers)
                               (vector-ref customers customer-idx)
                               0))
             (total-waiting (+ waiting-customers new-arrivals)))

        (if (and (>= customer-idx num-customers)
                 (= total-waiting 0))
            ; Base case: no more customers arriving and no more waiting
            (if any-customer-boarded?
                max-profit-minute
                -1) ; If no customers were ever boarded, return -1
            ; Recursive step
            (let* ((boarded-this-minute (min total-waiting 4))
                   (remaining-waiting (- total-waiting boarded-this-minute))
                   (profit-from-boarding (* boarded-this-minute boardingCost))
                   (profit-this-minute (- profit-from-boarding runningCost))
                   (next-current-profit (+ current-profit profit-this-minute))
                   (next-minutes-run (+ minutes-run 1))
                   (next-any-customer-boarded? (or any-customer-boarded? (> boarded-this-minute 0))))

              (loop (+ customer-idx 1)
                    remaining-waiting
                    next-current-profit
                    (cond
                      ((> next-current-profit max-profit) next-current-profit)
                      (else max-profit))
                    (cond
                      ((> next-current-profit max-profit) next-minutes-run)
                      (else max-profit-minute))
                    next-minutes-run
                    next-any-customer-boarded?))))))