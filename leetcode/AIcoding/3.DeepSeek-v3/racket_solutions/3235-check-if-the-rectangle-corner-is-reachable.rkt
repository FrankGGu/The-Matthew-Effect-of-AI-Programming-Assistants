(define (is-reachable targetX targetY)
  (let loop ([x targetX] [y targetY])
    (cond
      [(and (= x 1) (= y 1)) #t]
      [(= x y) #f]
      [(> x y) (loop (- x y) y)]
      [else (loop x (- y x))])))