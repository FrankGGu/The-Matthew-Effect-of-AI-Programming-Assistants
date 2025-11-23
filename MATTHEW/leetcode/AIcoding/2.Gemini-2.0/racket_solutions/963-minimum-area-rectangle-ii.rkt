(define (min-area-rect-ii points)
  (let* ([n (length points)]
         [min-area +inf.0])
    (for* ([i (in-range n)]
           [j (in-range i 0 -1)]
           [k (in-range n)])
      (when (not (equal? i k))
        (let* ([p1 (list-ref points i)]
               [p2 (list-ref points j)]
               [p3 (list-ref points k)]
               [vec1 (list (- (car p2) (car p1)) (- (cdr p2) (cdr p1)))]
               [vec2 (list (- (car p3) (car p1)) (- (cdr p3) (cdr p1)))]
               [dot-product (+ (* (car vec1) (car vec2)) (* (cdr vec1) (cdr vec2)))])
          (when (equal? dot-product 0)
            (let* ([dist1 (sqrt (+ (expt (car vec1) 2) (expt (cdr vec1) 2)))]
                   [dist2 (sqrt (+ (expt (car vec2) 2) (expt (cdr vec2) 2)))]
                   [area (* dist1 dist2)])
              (set! min-area (min min-area area)))))))
    (if (equal? min-area +inf.0)
        0.0
        min-area)))