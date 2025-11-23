(define (is-perfect-rectangle rectangles)
  (if (null? rectangles)
      #f
      (let* ([first-rect (car rectangles)]
             [min-x (car first-rect)]
             [min-y (cadr first-rect)]
             [max-x (caddr first-rect)]
             [max-y (cadddr first-rect)]
             [total-area 0]
             [points-count (make-hash)])

        (for-each (lambda (rect)
                    (let ([x1 (car rect)]
                          [y1 (cadr rect)]
                          [x2 (caddr rect)]
                          [y2 (cadddr rect)])
                      (set! min-x (min min-x x1))
                      (set! min-y (min min-y y1))
                      (set! max-x (max max-x x2))
                      (set! max-y (max max-y y2))
                      (set! total-area (+ total-area (* (- x2 x1) (- y2 y1))))

                      (define (add-point p)
                        (hash-set! points-count p (+ (hash-ref points-count p 0) 1)))

                      (add-point (list x1 y1))
                      (add-point (list x2 y1))
                      (add-point (list x1 y2))
                      (add-point (list x2 y2))))
                  rectangles)

        (let ([bounding-box-area (* (- max-x min-x) (- max-y min-y))])
          (if (not (= total-area bounding-box-area))
              #f
              (let ([odd-count-points (list)]
                    [expected-corners (list (list min-x min-y)
                                            (list max-x min-y)
                                            (list min-x max-y)
                                            (list max-x max-y))])

                (hash-for-each
                 points-count
                 (lambda (point count)
                   (when (odd? count)
                     (set! odd-count-points (cons point odd-count-points)))))

                (and (= (length odd-count-points) 4)
                     (andmap (lambda (p) (member p expected-corners equal?)) odd-count-points)
                     (andmap (lambda (p) (member p odd-count-points equal?)) expected-corners)))))))