(define (valid-sudoku? board)
  (define (row-valid? row)
    (define (helper lst seen)
      (cond
        [(empty? lst) #t]
        [else
         (let ([x (car lst)])
           (cond
             [(equal? x #\.) (helper (cdr lst) seen)]
             [(member x seen) #f]
             [else (helper (cdr lst) (cons x seen))]))]))
    (helper row '()))

  (define (col-valid? col)
    (row-valid? col))

  (define (block-valid? block)
    (row-valid? block))

  (define (get-column board col-index)
    (map (lambda (row) (list-ref row col-index)) board))

  (define (get-block board row-start col-start)
    (flatten
     (list
      (take (drop (list-ref board row-start) col-start) 3)
      (take (drop (list-ref board (+ row-start 1)) col-start) 3)
      (take (drop (list-ref board (+ row-start 2)) col-start) 3))))

  (and
   (andmap row-valid? board)
   (andmap col-valid? (map (lambda (i) (get-column board i)) (range 0 9)))
   (andmap block-valid?
           (list
            (get-block board 0 0)
            (get-block board 0 3)
            (get-block board 0 6)
            (get-block board 3 0)
            (get-block board 3 3)
            (get-block board 3 6)
            (get-block board 6 0)
            (get-block board 6 3)
            (get-block board 6 6)))))