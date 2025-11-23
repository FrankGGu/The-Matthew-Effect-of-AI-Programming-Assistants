(define (canCatchUp player1 player2 time)
  (define distance (abs (- (car player1) (car player2))))
  (define speed1 (cadr player1))
  (define speed2 (cadr player2))
  (define relative-speed (- speed2 speed1))
  (if (<= relative-speed 0)
      #t
      (<= (/ distance relative-speed) time)))

(define (chaseGame player1 player2 time)
  (if (canCatchUp player1 player2 time)
      "Yes"
      "No"))