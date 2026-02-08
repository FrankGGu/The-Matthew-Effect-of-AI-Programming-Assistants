(define (total-n-queens n)
  (define (backtrack row cols diag1 diag2)
    (if (= row n)
        1
        (foldl (lambda (col acc)
                  (if (or (set-member? cols col)
                          (set-member? diag1 (- row col))
                          (set-member? diag2 (+ row col)))
                      acc
                      (+ acc (backtrack (+ row 1) 
                                       (set-add cols col) 
                                       (set-add diag1 (- row col)) 
                                       (set-add diag2 (+ row col))))))
                0
                (range n)))
  (backtrack 0 (set) (set) (set)))

(define (solve-n-queens n)
  (total-n-queens n))