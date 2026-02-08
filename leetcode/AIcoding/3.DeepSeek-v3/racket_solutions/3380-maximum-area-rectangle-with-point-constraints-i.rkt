(define/contract (max-area-rect points)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let ([point-set (for/set ([p points]) p)]
        [max-area 0])
    (for* ([i (in-list points)]
           [j (in-list points)]
           #:unless (equal? i j)
           #:when (and (not (= (first i) (first j)))
                       (not (= (second i) (second j))))
           #:when (and (set-member? point-set (list (first i) (second j)))
                       (set-member? point-set (list (first j) (second i)))))
           [area (in-value (abs (* (- (first i) (first j))
                                     (- (second i) (second j)))))])
      (when (> area max-area)
        (set! max-area area)))
    max-area))