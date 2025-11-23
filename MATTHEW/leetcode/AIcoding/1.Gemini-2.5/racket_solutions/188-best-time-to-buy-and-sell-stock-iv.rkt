(define (max-profit k prices)
  (define n (length prices))

  (cond
    ((= n 0) 0) ; No prices, no profit
    ((>= k (/ n 2)) ; If k is large enough, it's equivalent to unlimited transactions
     (let loop ((prices-rest (cdr prices)) (profit 0) (prev-price (car prices)))
       (if (empty? prices-rest)
           profit
           (let* ((current-price (car prices-rest))
                  (diff (- current-price prev-price)))
             (loop (cdr prices-rest) (+ profit (max 0 diff)) current-price)))))
    (else ; Limited transactions case (DP approach)
     ;; dp-buy[t] stores the maximum profit after 't' transactions, ending with holding a stock.
     ;; dp-sell[t] stores the maximum profit after 't' transactions, ending with not holding a stock.
     ;; Initialize dp-buy with a large negative number (representing -infinity)
     ;; and dp-sell with 0.
     (define dp-buy (make-vector (+ k 1) (- (expt 10 9))))
     (define dp-sell (make-vector (+ k 1) 0))

     (for-each
      (lambda (price)
        ;; Iterate transactions from k down to 1.
        ;; This ensures that when calculating dp-buy[t], dp-sell[t-1] refers to
        ;; the value from the previous day's calculation for (t-1) transactions,
        ;; not the current day's updated value for (t-1) transactions.
        (for ((t k) #:when (> t 0))
          (vector-set! dp-buy t (max (vector-ref dp-buy t)
                                     (- (vector-ref dp-sell (- t 1)) price)))
          (vector-set! dp-sell t (max (vector-ref dp-sell t)
                                      (+ (vector-ref dp-buy t) price)))))
      prices)

     (vector-ref dp-sell k))))