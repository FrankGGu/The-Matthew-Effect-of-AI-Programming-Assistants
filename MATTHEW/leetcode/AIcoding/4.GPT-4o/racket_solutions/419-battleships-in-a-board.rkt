(define (countBattleships board)
  (define (is-valid? row col)
    (and (>= row 0) (< row (length board))
         (>= col 0) (< col (length (vector-ref board 0)))))

  (define count 0)

  (for ([i (in-range (length board))])
    (for ([j (in-range (length (vector-ref board i)))])
      (when (and (equal? (vector-ref (vector-ref board i) j) \X)
                 (or (not (is-valid? (- i 1) j))
                     (not (equal? (vector-ref (vector-ref board (- i 1)) j) \X)))
                 (or (not (is-valid? i (- j 1)))
                     (not (equal? (vector-ref (vector-ref board i (- j 1))) \X))))
        (set! count (+ count 1)))))

  count)