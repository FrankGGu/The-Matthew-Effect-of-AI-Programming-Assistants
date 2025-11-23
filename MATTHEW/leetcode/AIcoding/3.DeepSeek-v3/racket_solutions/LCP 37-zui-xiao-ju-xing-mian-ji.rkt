(define (min-area-rect points)
  (let* ([point-set (for/set ([p points]) p)]
         [n (length points)]
         [min-area +inf.0])
    (for ([i (in-range n)])
      (for ([j (in-range n)])
        (let ([p1 (list-ref points i)]
              [p2 (list-ref points j)])
          (when (and (not (equal? p1 p2))
                     (not (= (first p1) (first p2)))
                     (not (= (second p1) (second p2))))
            (let ([p3 (list (first p1) (second p2))]
              [p4 (list (first p2) (second p1))])
              (when (and (set-member? point-set p3)
                         (set-member? point-set p4))
                (let ([area (* (abs (- (first p1) (first p2)))
                               (abs (- (second p1) (second p2))))])
                  (when (< area min-area)
                    (set! min-area area)))))))))
    (if (= min-area +inf.0) 0 min-area)))