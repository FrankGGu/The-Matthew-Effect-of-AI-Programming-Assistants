(define (min-area-rect points)
  (define point-set (make-hash))
  (for ([p points])
    (hash-set! point-set (list (first p) (second p)) #t))

  (define (has-point? x y)
    (hash-ref point-set (list x y) #f))

  (define min-area +inf.0)

  (for ([i (range 0 (length points))])
    (for ([j (range (+ i 1) (length points))])
      (define p1 (list-ref points i))
      (define p2 (list-ref points j))

      (define x1 (first p1))
      (define y1 (second p1))
      (define x2 (first p2))
      (define y2 (second p2))

      (when (and (not (= x1 x2)) (not (= y1 y2)))
        (when (and (has-point? x1 y2) (has-point? x2 y1))
          (define area (* (abs (- x1 x2)) (abs (- y1 y2))))
          (set! min-area (min min-area area))))))

  (if (= min-area +inf.0)
      0
      min-area))