(define/contract (tictactoe moves)
  (-> (listof (listof exact-integer?)) string?)
  (define grid (make-vector 9 #f))
  (define (check-win player)
    (define win-patterns '((0 1 2) (3 4 5) (6 7 8)
                          (0 3 6) (1 4 7) (2 5 8)
                          (0 4 8) (2 4 6)))
    (for/or ([pattern win-patterns])
      (for/and ([pos pattern])
        (equal? (vector-ref grid pos) player))))

  (for ([move (in-list moves)]
        [i (in-naturals)])
    (define row (first move))
    (define col (second move))
    (define pos (+ (* row 3) col))
    (vector-set! grid pos (if (even? i) "A" "B")))

  (cond
    [(check-win "A") "A"]
    [(check-win "B") "B"]
    [(= (length moves) 9) "Draw"]
    [else "Pending"]))