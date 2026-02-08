(define (max-moves pawns enemies)
  (let loop ([pawns (sort pawns <)]
             [enemies (sort enemies <)]
             [moves 0])
    (cond
      [(or (null? pawns) (null? enemies))
       moves]
      [else
       (let ([pawn (car pawns)]
             [enemy (car enemies)])
         (cond
           [(< pawn enemy)
            (loop (cdr pawns) enemies moves)]
           [else
            (loop (cdr pawns) (cdr enemies) (add1 moves))]))])))