(define (knightProbability n k row col)
  (define (is-in-board? r c)
    (and (>= r 0) (< r n) (>= c 0) (< c n)))

  (define (dp r c moves)
    (if (not (is-in-board? r c))
        0
        (if (= moves 0)
            1
            (define directions '((2 1) (2 -1) (-2 1) (-2 -1) (1 2) (1 -2) (-1 2) (-1 -2)))
            (apply + (map (lambda (dir)
                            (dp (+ r (car dir)) (+ c (cadr dir)) (- moves 1)))
                          directions)))))

  (define total-probability (dp row col k))
  (/ total-probability (expt 8 k)))

(define (knightProbabilityWrapper n k row col)
  (knightProbability n k row col))