(define/contract (solve-sudoku board)
  (-> (listof (listof char?)) void?)
  (define (solve)
    (let loop ([row 0] [col 0])
      (cond
        [(= row 9) #t]
        [(= col 9) (loop (add1 row) 0)]
        [(not (char=? (list-ref (list-ref board row) col) #\.)) (loop row (add1 col))]
        [else
         (for ([num (in-range 1 10)])
           (let ([c (integer->char (+ (char->integer #\0) num))])
             (when (valid? row col c)
               (list-set! (list-ref board row) col c)
               (if (loop row (add1 col)) #t
                   (list-set! (list-ref board row) col #\.)))))
         #f])))

  (define (valid? row col c)
    (and (not (member c (list-ref board row)))
    (for/and ([i (in-range 9)])
      (not (char=? (list-ref (list-ref board i) col) c)))
    (let ([box-row (* (quotient row 3) 3)]
          [box-col (* (quotient col 3) 3)])
      (for*/and ([i (in-range box-row (+ box-row 3))]
                 [j (in-range box-col (+ box-col 3))])
        (not (char=? (list-ref (list-ref board i) j) c)))))

  (solve))