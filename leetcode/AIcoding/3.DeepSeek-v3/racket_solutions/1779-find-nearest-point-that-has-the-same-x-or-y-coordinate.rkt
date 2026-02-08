(define/contract (nearest-valid-point x y points)
  (-> exact-integer? exact-integer? (listof (listof exact-integer?)) exact-integer?)
  (define (valid? point)
    (or (= x (first point)) (= y (second point))))

  (define valid-points (filter valid? points))

  (if (null? valid-points)
      -1
      (let ([min-dist (apply min (map (lambda (p) (+ (abs (- x (first p))) (abs (- y (second p))))) valid-points))])
        (car (indexes-of (map (lambda (p) (+ (abs (- x (first p))) (abs (- y (second p))))) valid-points) min-dist)))))