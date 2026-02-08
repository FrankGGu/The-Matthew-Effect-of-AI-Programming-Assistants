(define (solveNQueens n)
  (define (is-safe? board row col)
    (and
     (not (ormap (lambda (c) (= c col)) board))
     (not (ormap (lambda (r c) (= (+ r c) (+ row col))) (range 0 row) (take board row)))
     (not (ormap (lambda (r c) (= (- r c) (- row col))) (range 0 row) (take board row)))))

  (define (solve-n-queens-recursive row board)
    (if (= row n)
        (list board)
        (foldr
         (lambda (col acc)
           (if (is-safe? board row col)
               (append (solve-n-queens-recursive (+ row 1) (append board (list col))) acc)
               acc))
         '()
         (range 0 n))))

  (define (board-to-string board)
    (map (lambda (col)
           (string-append (make-string col #\.) "Q" (make-string (- n col 1) #\.)))
         board))

  (map board-to-string (solve-n-queens-recursive 0 '())))