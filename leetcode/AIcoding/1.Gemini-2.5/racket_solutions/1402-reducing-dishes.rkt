#lang racket

(define (max-satisfaction satisfaction)
  (let* ([sorted-satisfaction (sort satisfaction <)]
         [reversed-sorted-satisfaction (reverse sorted-satisfaction)])
    (let-values ([(max-coeff _ __)
                  (for/fold ([max-coeff 0] [current-sum 0] [total-coeff 0])
                            ([dish reversed-sorted-satisfaction])
                    (let* ([new-current-sum (+ current-sum dish)]
                           [new-total-coeff (+ total-coeff new-current-sum)])
                      (values (max max-coeff new-total-coeff) new-current-sum new-total-coeff)))])
      max-coeff)))