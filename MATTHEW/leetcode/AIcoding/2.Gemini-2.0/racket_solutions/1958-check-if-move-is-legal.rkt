(define (check-move board r c color)
  (define n (vector-length board))
  (define (valid? row col)
    (and (>= row 0) (< row n) (>= col 0) (< col n)))
  (define (check-dir dr dc)
    (let loop ([row (+ r dr)] [col (+ c dc)] [found-opponent? #f])
      (cond
        [(not (valid? row col)) #f]
        [(equal? (vector-ref (vector-ref board row) col) #\.) #f]
        [(equal? (vector-ref (vector-ref board row) col) color) found-opponent?]
        [else (loop (+ row dr) (+ col dc) #t)])))
  (or (check-dir -1 0) (check-dir 1 0) (check-dir 0 -1) (check-dir 0 1)
      (check-dir -1 -1) (check-dir -1 1) (check-dir 1 -1) (check-dir 1 1)))