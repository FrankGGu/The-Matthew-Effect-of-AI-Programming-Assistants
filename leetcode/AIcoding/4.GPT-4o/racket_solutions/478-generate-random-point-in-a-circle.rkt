(define RandomPointInCircle
  (let ([radius 0]
        [xCenter 0]
        [yCenter 0])
    (define (init r x y)
      (set! radius r)
      (set! xCenter x)
      (set! yCenter y))
    (define (rand-point)
      (define theta (random (* 2 pi)))
      (define r (sqrt (random) * radius))
      (define x (+ xCenter (* r (cos theta))))
      (define y (+ yCenter (* r (sin theta))))
      (list x y))
    (list init rand-point)))

(define obj (RandomPointInCircle))
((car obj) 1 0 0)
((cadr obj))