(define (tictactoe moves)
  (define board (make-vector 3 (make-vector 3 ' ')))
  (define (set-move player x y)
    (vector-set! (vector-ref board x) y player))

  (for ([i (in-range (length moves))])
    (let* ([move (list-ref moves i)]
           [player (if (= (modulo i 2) 0) 'X 'O')]
           [x (car move)]
           [y (cadr move)])
      (set-move player x y)))

  (define (check-win player)
    (or (for/or ([i (in-range 3)])
          (and (equal? (vector-ref (vector-ref board i) 0) player)
               (equal? (vector-ref (vector-ref board i) 1) player)
               (equal? (vector-ref (vector-ref board i) 2) player)))
        (for/or ([i (in-range 3)])
          (and (equal? (vector-ref (vector-ref board 0) i) player)
               (equal? (vector-ref (vector-ref board 1) i) player)
               (equal? (vector-ref (vector-ref board 2) i) player)))
        (and (equal? (vector-ref (vector-ref board 0) 0) player)
             (equal? (vector-ref (vector-ref board 1) 1) player)
             (equal? (vector-ref (vector-ref board 2) 2) player))
        (and (equal? (vector-ref (vector-ref board 0) 2) player)
             (equal? (vector-ref (vector-ref board 1) 1) player)
             (equal? (vector-ref (vector-ref board 2) 0) player))))

  (if (check-win 'X)
      "X"
      (if (check-win 'O)
          "O"
          (if (= (length moves) 9)
              "Draw"
              "Pending")))))