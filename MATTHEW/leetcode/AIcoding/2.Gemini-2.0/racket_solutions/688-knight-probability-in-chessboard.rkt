(define (knight-probability n k row column)
  (define (valid? r c)
    (and (>= r 0) (< r n) (>= c 0) (< c n)))

  (define moves
    '((-2 -1) (-2 1) (-1 -2) (-1 2) (1 -2) (1 2) (2 -1) (2 1)))

  (define (solve k row column memo)
    (cond
      [(= k 0) 1.0]
      [(hash-has-key? memo (list k row column)) (hash-ref memo (list k row column))]
      [else
       (let ([prob (foldl + 0.0 (map (lambda (move)
                                        (let ([new-row (+ row (first move))]
                                              [new-col (+ column (second move))])
                                          (if (valid? new-row new-col)
                                              (/ (solve (- k 1) new-row new-col memo) 8.0)
                                              0.0)))
                                      moves))])
         (hash-set! memo (list k row column) prob)
         prob)]))

  (solve k row column (make-hash)))