(define (PredictTheWinner nums)
  (define (solve nums p1-score p2-score turn)
    (cond
      [(empty? nums) (>= p1-score p2-score)]
      [(equal? turn #t)
       (or (solve (cdr nums) (+ p1-score (car nums)) p2-score #f)
           (solve (drop-right nums 1) (+ p1-score (last nums)) p2-score #f))]
      [else
       (and (solve (cdr nums) p1-score (+ p2-score (car nums)) #t)
            (solve (drop-right nums 1) p1-score (+ p2-score (last nums)) #t))]))

  (solve nums 0 0 #t))