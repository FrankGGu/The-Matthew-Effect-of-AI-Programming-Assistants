(define (maximumSpending prices budget)
  (define (helper prices budget)
    (if (null? prices)
        0
        (let ((price (car prices)))
          (if (<= price budget)
              (max price (helper (cdr prices) budget))
              (helper (cdr prices) budget)))))
  (helper prices budget))

(maximumSpending '(1 3 5 7) 6)