#lang racket

(define ATM%
  (class object%
    (init-field [banknotes (vector 0 0 0 0 0)]) ; Stores counts of [20, 50, 100, 200, 500] banknotes

    (define denominations (vector 20 50 100 200 500))

    (define/public (deposit banknotes-count)
      (for ([i (range 5)])
        (vector-set! banknotes i (+ (vector-ref banknotes i) (list-ref banknotes-count i)))))

    (define/public (withdraw amount)
      (let* ([temp-banknotes (vector-copy banknotes)] ; Create a temporary copy for trial withdrawal
             [withdrawal-result (vector 0 0 0 0 0)]
             [remaining-amount amount])

        ; Iterate from largest denomination to smallest
        (for ([i (range 4 -1 -1)]) ; i from 4 (500) down to 0 (20)
          (let* ([denom (vector-ref denominations i)]
                 [available-count (vector-ref temp-banknotes i)]
                 [num-to-take (min available-count (floor (/ remaining-amount denom)))])
            (when (> num-to-take 0)
              (set! remaining-amount (- remaining-amount (* num-to-take denom)))
              (vector-set! withdrawal-result i num-to-take)
              (vector-set! temp-banknotes i (- available-count num-to-take)))))

        (if (= remaining-amount 0)
            (begin
              ; If withdrawal is successful, update the actual banknotes in the ATM
              (set! banknotes temp-banknotes)
              (vector->list withdrawal-result)) ; Return the result as a list
            (list -1)))))) ; Return [-1] if withdrawal is not possible

(define ATM ATM%) ; Alias ATM% to ATM for LeetCode's expected class name