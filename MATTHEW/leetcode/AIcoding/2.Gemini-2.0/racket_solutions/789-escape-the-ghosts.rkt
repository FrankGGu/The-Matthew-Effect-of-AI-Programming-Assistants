(define (escapeGhosts ghosts target)
  (define (manhattan-distance p1 p2)
    (+ (abs (- (car p1) (car p2)))
       (abs (- (cdr p1) (cdr p2)))))

  (let ((player-dist (manhattan-distance '(0 . 0) target)))
    (not (ormap (lambda (ghost)
                  (<= (manhattan-distance ghost target) player-dist))
                ghosts))))