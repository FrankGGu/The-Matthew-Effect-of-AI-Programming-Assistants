(define (solve-sudoku board)
  (define (is-valid? row col num)
    (define (check-row) (not (member num (list-ref board row))))
    (define (check-col) (not (member num (map (lambda (r) (list-ref r col)) board))))
    (define (check-box)
      (let* ([box-row (* 3 (quotient row 3))]
             [box-col (* 3 (quotient col 3))]
             [nums (append*
                    (map (lambda (i)
                           (map (lambda (j) (list-ref (list-ref board (+ box-row i)) (+ box-col j)))
                           (range 3)))
                         (range 3)))])
        (not (member num nums))))
    (and (check-row) (check-col) (check-box)))

  (define (backtrack)
    (let loop ([row 0] [col 0])
      (cond [(= row 9) #t]
            [(= col 9) (loop (+ row 1) 0)]
            [(not (= (list-ref (list-ref board row) col) #\0))
             (loop row (+ col 1))]
            [else
             (for-each (lambda (num)
                         (when (is-valid? row col num)
                           (set! (list-ref (list-ref board row) col) num)
                           (when (backtrack) (return #t))
                           (set! (list-ref (list-ref board row) col) #\0)))
                       (range 1 10))
             #f])))

  (backtrack))