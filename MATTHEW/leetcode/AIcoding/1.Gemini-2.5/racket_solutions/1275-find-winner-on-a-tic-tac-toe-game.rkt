(define (check-winner board-vec player-mark)
  (define (get-cell r c) (vector-ref (vector-ref board-vec r) c))

  (or (for/or ([r (in-range 3)])
        (and (= (get-cell r 0) player-mark)
             (= (get-cell r 1) player-mark)
             (= (get-cell r 2) player-mark)))

      (for/or ([c (in-range 3)])
        (and (= (get-cell 0 c) player-mark)
             (= (get-cell 1 c) player-mark)
             (= (get-cell 2 c) player-mark)))

      (and (= (get-cell 0 0) player-mark)
           (= (get-cell 1 1) player-mark)
           (= (get-cell 2 2) player-mark))

      (and (= (get-cell 0 2) player-mark)
           (= (get-cell 1 1) player-mark)
           (= (get-cell 2 0) player-mark))))

(define (tic-tac-toe moves)
  (define board-vec (build-vector 3 (lambda (i) (build-vector 3 (lambda (j) 0)))))
  (define current-player 1)
  (define num-moves 0)

  (define (process-moves remaining-moves)
    (if (empty? remaining-moves)
        (if (= num-moves 9)
            "Draw"
            "Pending")
        (let* ([move (first remaining-moves)]
               [r (list-ref move 0)]
               [c (list-ref move 1)])

          (vector-set! (vector-ref board-vec r) c current-player)
          (set! num-moves (+ num-moves 1))

          (if (check-winner board-vec current-player)
              (if (= current-player 1) "A" "B")
              (begin
                (set! current-player (if (= current-player 1) 2 1))
                (process-moves (rest remaining-moves)))))))

  (process-moves moves))