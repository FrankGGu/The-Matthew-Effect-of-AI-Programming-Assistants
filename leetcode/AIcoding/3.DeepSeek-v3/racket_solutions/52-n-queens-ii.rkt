(define (totalNQueens n)
  (define (attack? x1 y1 x2 y2)
    (or (= x1 x2)
        (= y1 y2)
        (= (+ x1 y1) (+ x2 y2))
        (= (- x1 y1) (- x2 y2))))

  (define (safe? board x y)
    (for/and ([pos (in-list board)])
      (not (attack? (car pos) (cdr pos) x y)))

  (define (solve board row)
    (if (= row n)
        1
        (for/sum ([col (in-range n)])
          (if (safe? board row col)
              (solve (cons (cons row col) board) (+ row 1))
              0)))

  (solve '() 0))