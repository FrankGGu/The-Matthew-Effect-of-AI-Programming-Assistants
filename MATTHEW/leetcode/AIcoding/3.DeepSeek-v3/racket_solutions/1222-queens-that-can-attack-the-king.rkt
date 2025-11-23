(define (queens-attack-the-king queens king)
  (define (on-board? x y)
    (and (>= x 0) (< x 8) (>= y 0) (< y 8)))
  (define (attack-direction dx dy)
    (let loop ([x (car king)] [y (cadr king)])
      (let ([nx (+ x dx)] [ny (+ y dy)])
        (cond
          [(not (on-board? nx ny)) '()]
          [(member (list nx ny) queens) (list (list nx ny))]
          [else (loop nx ny)]))))
  (let ([directions '((-1 -1) (-1 0) (-1 1) (0 -1) (0 1) (1 -1) (1 0) (1 1))])
    (apply append (map (lambda (d) (attack-direction (car d) (cadr d))) directions))))