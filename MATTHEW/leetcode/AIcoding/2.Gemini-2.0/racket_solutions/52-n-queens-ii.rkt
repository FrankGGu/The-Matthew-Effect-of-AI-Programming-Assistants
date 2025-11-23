(define (totalNQueens n)
  (letrec ([safe? (lambda (row col queens)
                     (cond [(null? queens) #t]
                           [(or (= (car queens) row)
                                (= (cdr queens) col)
                                (= (- (car queens) (cdr queens)) (- row col))
                                (= (+ (car queens) (cdr queens)) (+ row col))) #f]
                           [else (safe? row col (cdr queens))]
                           ))]
           [solve-n-queens (lambda (row queens)
                              (if (= row n)
                                  1
                                  (let loop ([col 0]
                                             [count 0])
                                    (cond [(>= col n) count]
                                          [(safe? row col queens) (loop (+ col 1) (+ count (solve-n-queens (+ row 1) (cons (cons row col) queens))))]
                                          [else (loop (+ col 1) count)]))))])
    (solve-n-queens 0 '())))