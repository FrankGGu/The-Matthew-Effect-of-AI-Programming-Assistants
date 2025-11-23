(define (queensCanAttacktheKing queens king)
  (define (in-bounds? x y)
    (and (>= x 0) (< x 8) (>= y 0) (< y 8)))

  (define directions '((-1 -1) (-1 0) (-1 1) (0 -1) (0 1) (1 -1) (1 0) (1 1)))

  (define (find-queens dir)
    (let loop ((x (car dir)) (y (cadr dir)) (result '()))
      (if (not (in-bounds? x y))
          result
          (if (member (list x y) queens)
              (cons (list x y) result)
              (loop (+ x (car dir)) (+ y (cadr dir)) result)))))

  (apply append (map find-queens directions)))