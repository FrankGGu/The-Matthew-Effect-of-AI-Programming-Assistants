(define (furthest-point-from-origin s)
  (let ([left-right (count #\L s)]
        [right-right (count #\R s)]
        [underscore (count #\_ s)])
    (+ (abs (- left-right right-right)) underscore)))