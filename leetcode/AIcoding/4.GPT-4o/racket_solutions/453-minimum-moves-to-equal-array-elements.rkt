(define (minMoves nums)
  (define min-val (apply min nums))
  (apply + (map (lambda (x) (- x min-val)) nums)))

(minMoves '(1 2 3))