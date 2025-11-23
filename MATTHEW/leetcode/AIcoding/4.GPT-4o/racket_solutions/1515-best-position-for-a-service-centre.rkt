(define (bestCoordinate towers radius)
  (define (in-range? x1 y1 x2 y2 r)
    (<= (sqrt (+ (sqr (- x1 x2)) (sqr (- y1 y2)))) r))

  (define (get-quality x y)
    (apply + (map (lambda (tower)
                    (let ((x1 (car tower))
                          (y1 (cadr tower)))
                      (if (in-range? x y x1 y1 radius)
                          (floor (- radius (sqrt (+ (sqr (- x x1)) (sqr (- y y1)))))) 
                          0)))
                  towers)))

  (define best (list 0 0))
  (define max-quality 0)

  (for ([i (in-range 51)])
    (for ([j (in-range 51)])
      (let ((quality (get-quality i j)))
        (when (> quality max-quality)
          (set! max-quality quality)
          (set! best (list i j)))))))

  best)