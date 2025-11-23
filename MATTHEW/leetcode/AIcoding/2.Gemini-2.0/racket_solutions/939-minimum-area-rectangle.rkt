(define (min-area-rect points)
  (define point-set (make-set equal?))
  (for ([p points])
    (set-add! point-set p))

  (define min-area +inf.0)
  (for* ([i (in-range (length points))]
         [j (in-range (+ i 1) (length points))])
    (define p1 (list-ref points i))
    (define p2 (list-ref points j))
    (define x1 (car p1))
    (define y1 (cadr p1))
    (define x2 (car p2))
    (define y2 (cadr p2))

    (when (and (not (= x1 x2)) (not (= y1 y2)))
      (define p3 (list x1 y2))
      (define p4 (list x2 y1))
      (when (and (set-member? point-set p3) (set-member? point-set p4))
        (define area (* (abs (- x1 x2)) (abs (- y1 y2))))
        (set! min-area (min min-area area)))))

  (if (= min-area +inf.0)
      0
      min-area))