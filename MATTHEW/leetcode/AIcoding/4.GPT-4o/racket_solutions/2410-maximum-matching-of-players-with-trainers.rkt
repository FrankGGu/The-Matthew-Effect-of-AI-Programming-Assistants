(define (matchPlayersAndTrainers players trainers)
  (define sorted-players (sort players <))
  (define sorted-trainers (sort trainers <))
  (define (count-matches players trainers)
    (if (or (null? players) (null? trainers))
        0
        (let ((player (car players))
              (trainer (car trainers)))
          (if (<= player trainer)
              (+ 1 (count-matches (cdr players) (cdr trainers)))
              (count-matches players (cdr trainers))))))
  (count-matches sorted-players sorted-trainers))

(matchPlayersAndTrainers '(4 2 3) '(3 4 5 1))