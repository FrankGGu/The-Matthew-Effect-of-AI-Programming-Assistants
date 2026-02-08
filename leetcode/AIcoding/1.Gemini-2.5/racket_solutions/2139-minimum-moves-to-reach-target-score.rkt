(define (min-moves target max-doubles)
  (let loop ((current target)
             (doubles-left max-doubles)
             (moves 0))
    (cond
      ((= current 1) moves)
      ((= doubles-left 0) (+ moves (- current 1)))
      ((even? current)
       (loop (/ current 2)
             (- doubles-left 1)
             (+ moves 1)))
      (else ; current is odd
       (loop (- current 1)
             doubles-left
             (+ moves 1))))))