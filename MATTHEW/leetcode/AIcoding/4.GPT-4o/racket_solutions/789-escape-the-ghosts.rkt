(define (escape-ghosts ghosts target)
  (define (distance p1 p2)
    (+ (abs (- (car p1) (car p2)))
       (abs (- (cadr p1) (cadr p2))))
  (define player-distance (distance '(0 0) target))
  (define ghost-distances (map (lambda (ghost) (distance ghost target)) ghosts))
  (if (for/sum ((d ghost-distances)) (if (< d player-distance) 1 0))
      #f
      #t))