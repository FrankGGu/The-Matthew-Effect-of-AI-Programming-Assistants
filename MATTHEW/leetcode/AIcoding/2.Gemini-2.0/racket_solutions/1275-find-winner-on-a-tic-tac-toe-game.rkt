(define (tictactoe moves)
  (define board (make-vector 3 (make-vector 3 #f)))
  (define (update-board i j player)
    (vector-set! (vector-ref board i) j player))
  (define (check-win player)
    (or (for/or ([i (in-range 3)])
          (and (equal? (vector-ref (vector-ref board i) 0) player)
               (equal? (vector-ref (vector-ref board i) 1) player)
               (equal? (vector-ref (vector-ref board i) 2) player)))
        (for/or ([j (in-range 3)])
          (and (equal? (vector-ref (vector-ref board 0) j) player)
               (equal? (vector-ref (vector-ref board 1) j) player)
               (equal? (vector-ref (vector-ref board 2) j) player)))
        (and (equal? (vector-ref (vector-ref board 0) 0) player)
             (equal? (vector-ref (vector-ref board 1) 1) player)
             (equal? (vector-ref (vector-ref board 2) 2) player))
        (and (equal? (vector-ref (vector-ref board 0) 2) player)
             (equal? (vector-ref (vector-ref board 1) 1) player)
             (equal? (vector-ref (vector-ref board 2) 0) player))))
  (define (process-moves moves player)
    (cond [(empty? moves) #f]
          [else
           (let ([move (car moves)])
             (update-board (car move) (cadr move) player)
             (cond [(check-win player) player]
                   [else (process-moves (cdr moves) (if (equal? player "A") "B" "A"))]))]))
  (let ([winner (process-moves moves "A")])
    (cond [(equal? winner "A") "A"]
          [(equal? winner "B") "B"]
          [(= (length moves) 9) "Draw"]
          [else "Pending"])))