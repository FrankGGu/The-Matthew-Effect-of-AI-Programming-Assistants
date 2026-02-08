(define (orchestra-layout num xPos yPos)
  (let* ([n num]
         [x xPos]
         [y yPos]
         [layer (min x y (- (- n 1) x) (- (- n 1) y))]
         [outer-start (* 4 layer (- n layer))]
         [side (- n (* 2 layer) 1)])
    (cond
      [(= x layer) (+ outer-start (- y layer) 1)]
      [(= y (+ layer side)) (+ outer-start side (- x layer) 1)]
      [(= x (+ layer side)) (+ outer-start (* 2 side) (- (+ layer side) y) 1)]
      [else (+ outer-start (* 3 side) (- (+ layer side) x) 1)])))