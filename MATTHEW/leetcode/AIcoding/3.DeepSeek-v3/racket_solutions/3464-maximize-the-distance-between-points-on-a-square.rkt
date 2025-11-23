(define/contract (max-dist points)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let* ([min-x (apply min (map first points))]
         [max-x (apply max (map first points))]
         [min-y (apply min (map second points))]
         [max-y (apply max (map second points))])
    (max (- max-x min-x) (- max-y min-y))))