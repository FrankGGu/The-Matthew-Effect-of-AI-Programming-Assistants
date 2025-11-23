(define/contract (count-points points queries)
  (-> (listof (listof exact-integer?)) (listof (listof exact-integer?)) (listof exact-integer?))
  (map (lambda (query)
         (let ([x_j (first query)]
               [y_j (second query)]
               [r_j (third query)])
           (count (lambda (point)
                    (let ([x_i (first point)]
                          [y_i (second point)])
                      (<= (+ (expt (- x_i x_j) 2) (expt (- y_i y_j) 2)) (expt r_j 2)))
                  points))
       queries))