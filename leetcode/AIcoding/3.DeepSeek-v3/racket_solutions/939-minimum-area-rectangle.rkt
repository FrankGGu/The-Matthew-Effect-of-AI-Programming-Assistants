(define/contract (min-area-rect points)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let* ([point-set (for/set ([p points]) p)]
         [n (length points)]
         [min-area +inf.0])
    (for ([i (in-range n)])
      (for ([j (in-range i n)])
        (let ([p1 (list-ref points i)]
              [p2 (list-ref points j)])
          (when (and (not (equal? (first p1) (first p2)))
                     (not (equal? (second p1) (second p2))))
            (let ([p3 (list (first p1) (second p2))]
                  [p4 (list (first p2) (second p1))])
              (when (and (set-member? point-set p3)
                         (set-member? point-set p4))
                (let ([area (abs (* (- (first p1) (first p2))
                                    (- (second p1) (second p2))))])
                  (set! min-area (min min-area area)))))))))
    (if (= min-area +inf.0) 0 min-area)))