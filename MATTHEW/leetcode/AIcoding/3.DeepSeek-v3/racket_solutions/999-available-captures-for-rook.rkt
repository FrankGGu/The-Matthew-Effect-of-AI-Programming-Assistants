(define (num-rook-captures board)
  (let ([rook-row 0]
        [rook-col 0]
        [count 0])
    (for ([i (in-range 8)])
      (for ([j (in-range 8)])
        (when (char=? (list-ref (list-ref board i) j) #\R)
          (set! rook-row i)
          (set! rook-col j)))
    (let ([directions '((0 1) (1 0) (0 -1) (-1 0))])
      (for ([dir directions])
        (let ([dx (first dir)]
              [dy (second dir)]
              [x (+ rook-row dx)]
              [y (+ rook-col dy)])
          (let loop ([x x] [y y])
            (when (and (>= x 0) (< x 8) (>= y 0) (< y 8))
              (let ([cell (list-ref (list-ref board x) y)])
                (cond
                  [(char=? cell #\p) (set! count (+ count 1)) (loop -1 -1)]
                  [(char=? cell #\B) (loop -1 -1)]
                  [else (loop (+ x dx) (+ y dy))]))))))
    count))