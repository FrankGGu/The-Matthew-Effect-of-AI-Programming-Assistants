(define (max-profit prices)
  (define (helper prices profit)
    (cond [(null? prices) profit]
          [(null? (cdr prices)) profit]
          [else (helper (cdr prices) (+ profit (max 0 (- (cadr prices) (car prices)))))]))
  (helper prices 0))