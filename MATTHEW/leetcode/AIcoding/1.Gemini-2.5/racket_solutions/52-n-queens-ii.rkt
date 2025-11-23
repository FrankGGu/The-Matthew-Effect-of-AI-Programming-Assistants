#lang racket

(define (totalNQueens n)
  (define (solve row cols diag1 diag2)
    (if (= row n)
        1
        (for/sum ([col (in-range n)])
          (let ([current-diag1 (- row col)]
                [current-diag2 (+ row col)])
            (if (or (set-member? cols col)
                    (set-member? diag1 current-diag1)
                    (set-member? diag2 current-diag2))
                0
                (solve (+ row 1)
                       (set-add cols col)
                       (set-add diag1 current-diag1)
                       (set-add diag2 current-diag2)))))))

  (solve 0 (set) (set) (set)))