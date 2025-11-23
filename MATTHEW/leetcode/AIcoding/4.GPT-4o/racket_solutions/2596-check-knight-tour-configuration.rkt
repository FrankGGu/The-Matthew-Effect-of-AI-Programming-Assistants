(define (checkKnightTour(board))
  (define directions '((2 1) (2 -1) (-2 1) (-2 -1) (1 2) (1 -2) (-1 2) (-1 -2)))
  (define (is-valid x y)
    (and (>= x 0) (< x 8) (>= y 0) (< y 8)))
  (define (dfs x y move-number)
    (if (= move-number 64)
        #t
        (for/or ([d directions])
          (let ([new-x (+ x (car d))] [new-y (+ y (cadr d))])
            (when (and (is-valid new-x new-y) (equal? (list new-x new-y) (list (car (list-ref board new-x)) (cadr (list-ref board new-x)))))
              (dfs new-x new-y (+ move-number 1)))))))
  (dfs 0 0 1))

(checkKnightTour board)