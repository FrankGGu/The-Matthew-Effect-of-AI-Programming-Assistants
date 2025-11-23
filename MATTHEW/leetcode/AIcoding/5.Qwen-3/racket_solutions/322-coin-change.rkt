(define (coin-change coins amount)
  (define (helper amount memo)
    (cond [(= amount 0) 0]
          [(< amount 0) +inf.0]
          [else
           (let ((res (for/fold ([min-coins +inf.0])
                         ([coin (in-list coins)])
                       (min min-coins (+ 1 (helper (- amount coin) memo)))))
             (if (and (real? res) (not (inf? res))) res +inf.0))]))
  (let ((result (helper amount '())))
    (if (inf? result) -1 result)))