(define (count-lattice-points circles)
  (define (inside? x y circle)
    (let ([cx (list-ref circle 0)]
          [cy (list-ref circle 1)]
          [r (list-ref circle 2)])
      (<= (+ (sqr (- x cx)) (sqr (- y cy))) (sqr r))))

  (define points (make-hash))
  (for* ([circle circles])
    (let* ([cx (list-ref circle 0)]
           [cy (list-ref circle 1)]
           [r (list-ref circle 2)])
      (for ([x (in-range (- cx r) (+ cx r 1))])
        (for ([y (in-range (- cy r) (+ cy r 1))])
          (when (inside? x y circle)
            (hash-set! points (cons x y) #t))))))
  (hash-count points))