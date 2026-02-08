(define/contract (is-boomerang points)
  (-> (listof (listof exact-integer?)) boolean?)
  (let ([x1 (first (first points))]
        [y1 (second (first points))]
        [x2 (first (second points))]
        [y2 (second (second points))]
        [x3 (first (third points))]
        [y3 (second (third points))])
    (not (= (* (- x2 x1) (- y3 y1)) (* (- x3 x1) (- y2 y1))))))