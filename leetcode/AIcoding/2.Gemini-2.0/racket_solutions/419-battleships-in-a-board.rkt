(define (countBattleships board)
  (let* ([rows (length board)]
         [cols (length (car board))]
         [count 0])
    (for ([i (in-range rows)]
          [j (in-range cols)])
      (when (equal? (list-ref (list-ref board i) j) 'X)
        (cond
          [(and (>= i 1) (equal? (list-ref (list-ref board (- i 1)) j) 'X)) #f]
          [(and (>= j 1) (equal? (list-ref (list-ref board i) (- j 1)) 'X)) #f]
          [else (set! count (+ count 1))])))
    count))