(define (is-winner player1 player2)
  (define (calculate-score player)
    (let loop ([i 0] [score 0] [multiplier 1] [player player])
      (cond
        [(>= i (length player)) score]
        [else
         (let ([curr (list-ref player i)])
           (loop (+ i 1) (+ score (* multiplier curr))
                 (if (>= i 1)
                     (if (or (= (list-ref player (- i 1)) 10)
                             (and (>= i 2) (= (list-ref player (- i 2)) 10)))
                         2
                         1)
                     1)
                 player))])))
  (let ([score1 (calculate-score player1)]
        [score2 (calculate-score player2)])
    (cond
      [(> score1 score2) 1]
      [(< score1 score2) 2]
      [else 0])))