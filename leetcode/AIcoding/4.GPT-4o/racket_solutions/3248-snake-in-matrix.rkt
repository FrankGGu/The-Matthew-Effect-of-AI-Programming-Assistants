(define (snake-in-matrix n)
  (define matrix (make-vector n (make-vector n 0)))
  (define (fill-snake row col num dir)
    (if (and (>= row 0) (< row n) (>= col 0) (< col n) (= (vector-ref (vector-ref matrix row) col) 0))
        (begin
          (vector-set! (vector-ref matrix row) col num)
          (cond
            [(= dir 0) (fill-snake row (+ col 1) (+ num 1) dir)] ; right
            [(= dir 1) (fill-snake (+ row 1) col (+ num 1) dir)] ; down
            [(= dir 2) (fill-snake row (- col 1) (+ num 1) dir)] ; left
            [(= dir 3) (fill-snake (- row 1) col (+ num 1) dir)] ; up
            )
          )
        (begin
          (set! dir (modulo (+ dir 1) 4))
          (cond
            [(= dir 0) (fill-snake (+ row 1) col num dir)] ; right
            [(= dir 1) (fill-snake row (+ col 1) num dir)] ; down
            [(= dir 2) (fill-snake (- row 1) col num dir)] ; left
            [(= dir 3) (fill-snake row (- col 1) num dir)] ; up
            )
          )
        )
    )
  (fill-snake 0 0 1 0)
  (vector->list (vector-map (lambda (row) (vector->list row)) matrix)))

(snake-in-matrix 3)