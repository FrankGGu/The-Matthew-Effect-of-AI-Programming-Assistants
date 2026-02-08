(define (min-rectangles points)
  (define (solve points k)
    (if (null? points)
        0
        (let* ([n (length points)]
               [dp (make-vector (add1 n) +inf.0)])
          (vector-set! dp 0 0)
          (for ([i (in-range 1 (add1 n))])
            (for ([j (in-range (min k i) 0 -1)])
              (let* ([sub-points (take points i)]
                     [last-j-points (take (reverse sub-points) j)]
                     [x-coords (map first last-j-points)]
                     [y-coords (map second last-j-points)]
                     [min-x (apply min x-coords)]
                     [max-x (apply max x-coords)]
                     [min-y (apply min y-coords)]
                     [max-y (apply max y-coords)]
                     [area (* (- max-x min-x) (- max-y min-y))])
                (vector-set! dp i (min (vector-ref dp i) (+ area (vector-ref dp (- i j))))))))
          (vector-ref dp n))))

  (cond
    [(null? points) 0]
    [else (solve points 5)]))