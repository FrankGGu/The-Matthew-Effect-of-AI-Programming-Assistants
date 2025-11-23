(define (max-profit prices)
  (if (null? prices)
      0
      (let* ((buy1 (- (expt 10 18))) ; Max profit after first buy
             (sell1 0)               ; Max profit after first sell
             (buy2 (- (expt 10 18))) ; Max profit after second buy
             (sell2 0))              ; Max profit after second sell
        (for-each (lambda (price)
                    (set! buy1 (max buy1 (- price)))
                    (set! sell1 (max sell1 (+ buy1 price)))
                    (set! buy2 (max buy2 (- sell1 price)))
                    (set! sell2 (max sell2 (+ buy2 price))))
                  prices)
        sell2)))