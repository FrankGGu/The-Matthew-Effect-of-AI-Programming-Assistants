(define (random) (random 4294967087))

(define _radius 0)
(define _x_center 0)
(define _y_center 0)

(define (init radius x_center y_center)
  (set! _radius radius)
  (set! _x_center x_center)
  (set! _y_center y_center))

(define (rand-point)
  (let* ([theta (* (random) 2 pi)]
         [r (* _radius (sqrt (random)))]
         [x (+ _x_center (* r (cos theta)))]
         [y (+ _y_center (* r (sin theta)))])
    (list x y)))