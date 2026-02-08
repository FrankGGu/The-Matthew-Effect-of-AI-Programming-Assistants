(define (maxProfit prices fee)
  (define (helper prices hold cash)
    (if (null? prices)
        cash
        (let* ((price (car prices))
               (sell (if hold
                         (helper (cdr prices) #f (+ cash price - fee))
                         cash))
               (buy (if (not hold)
                        (helper (cdr prices) #t (+ cash price))
                        cash)))
          (max sell buy))))
  (helper prices #f 0))

(maxProfit '(1 3 2 8 4 9) 2)