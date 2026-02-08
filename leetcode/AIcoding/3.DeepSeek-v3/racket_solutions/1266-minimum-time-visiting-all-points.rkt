(define/contract (min-time-to-visit-all-points points)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (define (time p1 p2)
    (max (abs (- (first p1) (first p2)))
         (abs (- (second p1) (second p2))))))
  (if (null? (cdr points))
      0
      (+ (time (car points) (cadr points))
         (min-time-to-visit-all-points (cdr points)))))