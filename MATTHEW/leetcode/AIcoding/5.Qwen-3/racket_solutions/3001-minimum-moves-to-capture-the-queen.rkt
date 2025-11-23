(define (min-moves-to-capture-the-queen n pieces)
  (define (get-positions pieces)
    (map (lambda (p) (list-ref p 0) (list-ref p 1)) pieces))

  (define (is-attacked? x y)
    (let ((px (car pieces))
          (py (cadr pieces)))
      (or (= x px) (= y py) (= (- x y) (- px py)) (= (+ x y) (+ px py)))))

  (let loop ((x 0) (y 0) (moves 0))
    (cond ((= x n) (if (is-attacked? x y) moves (loop 0 (add1 y) moves)))
          ((= y n) (loop (add1 x) 0 (add1 moves)))
          ((is-attacked? x y) moves)
          (else (loop (add1 x) y moves)))))