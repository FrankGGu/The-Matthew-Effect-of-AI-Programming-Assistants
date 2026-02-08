(define (longest-increasing-path matrix)
  (define (valid? row col)
    (and (>= row 0) (< row rows) (>= col 0) (< col cols)))

  (define (dfs row col)
    (cond
      [(vector-ref (vector-ref memo row) col)
       (vector-ref (vector-ref memo row) col)]
      [else
       (let* ([val (vector-ref (vector-ref matrix row) col)]
              [up (if (and (valid? (- row 1) col) (> (vector-ref (vector-ref matrix (- row 1)) col) val))
                      (dfs (- row 1) col)
                      0) ]
              [down (if (and (valid? (+ row 1) col) (> (vector-ref (vector-ref matrix (+ row 1)) col) val))
                        (dfs (+ row 1) col)
                        0)]
              [left (if (and (valid? row (- col 1)) (> (vector-ref (vector-ref matrix row) (- col 1)) val))
                        (dfs row (- col 1))
                        0)]
              [right (if (and (valid? row (+ col 1)) (> (vector-ref (vector-ref matrix row) (+ col 1)) val))
                         (dfs row (+ col 1))
                         0)])
         (vector-set! (vector-ref memo row) col (+ 1 (max up down left right)))
         (vector-ref (vector-ref memo row) col))]))

  (define rows (vector-length matrix))
  (define cols (if (zero? rows) 0 (vector-length (vector-ref matrix 0))))
  (define memo (make-vector rows (lambda (i) (make-vector cols 0))))

  (let loop ([r 0] [max-len 0])
    (cond
      [(>= r rows) max-len]
      [else
       (let loop2 ([c 0] [max-len2 max-len])
         (cond
           [(>= c cols) (loop (+ r 1) max-len2)]
           [else (loop2 (+ c 1) (max max-len2 (dfs r c)))]))]))
  )