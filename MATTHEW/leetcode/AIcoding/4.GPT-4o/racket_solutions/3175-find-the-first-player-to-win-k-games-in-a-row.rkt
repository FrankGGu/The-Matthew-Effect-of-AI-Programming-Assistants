(define (firstPlayerToWinKGamesInARow players k)
  (define (check-winning-streak player games)
    (define (streak-helper games count)
      (cond
        ((null? games) #f)
        ((equal? (car games) player) (if (= (+ count 1) k) #t (streak-helper (cdr games) (+ count 1))))
        (else (streak-helper (cdr games) 0))))
    (streak-helper games 0))

  (define (find-player players games)
    (for/fold ([result #f]) ([player players])
      (if (or result (check-winning-streak player games))
          result
          player)))

  (find-player players (reverse players)))