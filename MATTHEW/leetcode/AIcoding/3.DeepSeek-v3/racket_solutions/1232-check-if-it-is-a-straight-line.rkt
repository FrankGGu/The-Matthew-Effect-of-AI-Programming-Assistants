(define/contract (check-straight-line coordinates)
  (-> (listof (listof exact-integer?)) boolean?)
  (let* ([x1 (first (first coordinates))]
         [y1 (second (first coordinates))]
         [x2 (first (second coordinates))]
         [y2 (second (second coordinates))]
         [dx (- x2 x1)]
         [dy (- y2 y1)])
    (for/and ([point (drop coordinates 2)])
      (let ([x (first point)]
            [y (second point)])
      (zero? (- (* dy (- x x1)) (* dx (- y y1)))))))