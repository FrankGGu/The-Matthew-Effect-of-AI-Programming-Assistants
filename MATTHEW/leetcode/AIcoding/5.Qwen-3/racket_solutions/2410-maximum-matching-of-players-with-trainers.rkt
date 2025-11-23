(define (match-player-with-trainer players trainers)
  (let ([players (sort players <)]
        [trainers (sort trainers <)])
    (let loop ([p 0] [t 0] [count 0])
      (cond [(or (>= p (length players)) (>= t (length trainers))) count]
            [(<= (list-ref players p) (list-ref trainers t))
             (loop (+ p 1) (+ t 1) (+ count 1))]
            [else
             (loop p (+ t 1) count)]))))

(define/contract (matchPlayersToTrainers players trainers)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (match-player-with-trainer players trainers))