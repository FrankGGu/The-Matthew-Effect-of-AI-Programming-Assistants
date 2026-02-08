(define (calculate-score rolls)
  (let loop ([index 0]
             [current-score 0]
             [rolls-remaining rolls]
             [prev1-roll -1]
             [prev2-roll -1])
    (if (empty? rolls-remaining)
        current-score
        (let* ([current-roll (car rolls-remaining)]
               [effective-roll (if (or (= prev1-roll 10) (= prev2-roll 10))
                                   (* current-roll 2)
                                   current-roll)])
          (loop (+ index 1)
                (+ current-score effective-roll)
                (cdr rolls-remaining)
                current-roll
                prev1-roll)))))

(define (determine-winner-of-a-bowling-game player1 player2)
  (let* ([score1 (calculate-score player1)]
         [score2 (calculate-score player2)])
    (cond
      [(> score1 score2) 1]
      [(> score2 score1) 2]
      [else 0])))