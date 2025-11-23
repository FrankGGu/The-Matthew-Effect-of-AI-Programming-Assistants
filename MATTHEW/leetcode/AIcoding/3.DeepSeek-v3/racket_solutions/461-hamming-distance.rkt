(define (hamming-distance x y)
  (let loop ((x x) (y y) (distance 0))
    (if (and (= x 0) (= y 0))
        distance
        (loop (arithmetic-shift x -1) 
              (arithmetic-shift y -1) 
              (+ distance (if (= (bitwise-and x 1) (bitwise-and y 1)) 0 1)))))