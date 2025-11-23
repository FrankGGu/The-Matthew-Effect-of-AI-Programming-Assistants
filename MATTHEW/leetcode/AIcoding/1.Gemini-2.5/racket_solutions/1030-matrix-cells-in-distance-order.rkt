(define (all-cells-dist-order R C r0 c0)
  (let* ([all-coords
          (for*/list ([r (range R)]
                      [c (range C)])
            (list r c))]
         [coords-with-dist
          (map (lambda (coord)
                 (let* ([r (car coord)]
                        [c (cadr coord)]
                        [dist (+ (abs (- r r0)) (abs (- c c0)))])
                   (list dist coord)))
               all-coords)]
         [sorted-coords-with-dist
          (sort coords-with-dist
                (lambda (a b)
                  (< (car a) (car b))))])
    (map cadr sorted-coords-with-dist)))