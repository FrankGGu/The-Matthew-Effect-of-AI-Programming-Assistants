(define (max-distance-between-points points)
  (let* ([n (length points)]
         [max-dist-sq 0]) ; Initialize with 0, as squared distance cannot be negative
    (when (>= n 2) ; Ensure there are at least two points to calculate distance
      (for ([i (in-range n)])
        (for ([j (in-range (+ i 1) n)]) ; Iterate through unique pairs (i, j) where j > i
          (let* ([p1 (list-ref points i)]
                 [p2 (list-ref points j)]
                 [x1 (car p1)]
                 [y1 (cadr p1)]
                 [x2 (car p2)]
                 [y2 (cadr p2)]
                 [dx (- x2 x1)]
                 [dy (- y2 y1)]
                 [current-dist-sq (+ (sqr dx) (sqr dy))])
            (set! max-dist-sq (max max-dist-sq current-dist-sq))))))
    (sqrt max-dist-sq)))