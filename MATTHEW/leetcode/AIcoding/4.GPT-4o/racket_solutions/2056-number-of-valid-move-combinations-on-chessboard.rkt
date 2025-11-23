(define (countValidMoves n k)
  (define (is-in-bounds x y)
    (and (>= x 0) (< x n) (>= y 0) (< y n)))

  (define directions '((1 2) (1 -2) (-1 2) (-1 -2) (2 1) (2 -1) (-2 1) (-2 -1)))

  (define (dfs x y moves)
    (if (= moves k)
        1
        (apply + 
               (map (λ (d)
                      (let ((new-x (+ x (car d)))
                            (new-y (+ y (cadr d))))
                        (if (is-in-bounds new-x new-y)
                            (dfs new-x new-y (+ moves 1))
                            0)))
                    directions))))

  (dfs 0 0 0))

(define (numberOfValidMoveCombinations n k)
  (countValidMoves n k))