#lang racket

(define (minimum-operations-to-make-array-empty nums)
  (define counts (make-hash))

  ;; Populate frequency counts for each number
  (for-each (lambda (num)
              (hash-set! counts num (add1 (hash-ref counts num 0))))
            nums)

  ;; Calculate total operations using for/fold
  ;; Accumulators: [total-ops initial-total-ops] [possible? initial-possible?]
  (define result
    (for/fold ([total-ops 0]
               [possible? #t])
              ([count (in-list (hash-values counts))])
      ;; If it's already impossible, propagate the impossible state
      (if (not possible?)
          (values total-ops possible?)
          ;; Otherwise, check the current count
          (cond
            [(= count 1)
             ;; If count is 1, it's impossible to remove
             (values total-ops #f)]
            [else
             ;; For any count > 1, operations needed is ceil(count / 3)
             ;; which can be calculated as (count + 2) / 3 using integer division
             (values (+ total-ops (quotient (+ count 2) 3)) possible?)]))))

  ;; Return total operations if possible, otherwise -1
  (if (cdr result) ;; Check if possible? (the second element of the pair) is true
      (car result) ;; Return total-ops (the first element of the pair)
      -1))